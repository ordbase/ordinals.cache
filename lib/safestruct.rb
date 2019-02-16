# encoding: utf-8

require 'pp'
require 'forwardable'     # uses def_delegator


## our own code
require 'safestruct/version'    # note: let version always go first

require 'safestruct/safe_array'
require 'safestruct/safe_hash'
require 'safestruct/safe_struct'



####################################
## add zero/zero_new machinery for builin classes

#### value semantics
class Integer
  def self.zero() 0; end      ## note: 0.frozen? == true  by default
end

class Bool
  def self.zero() false; end   ## note: false.frozen? == true  by default
end

#### reference semantics (new copy ALWAYS needed)
class String
  def self.new_zero() new; end
  def self.zero() @zero ||= new_zero.freeze;  end
end




#####
# add "beautiful" convenience helpers

class Hash

  def self.of( *args )
     ## e.g. gets passed in [{Address=>Integer}]
     ##  check for Integer - use Hash.new(0)
     ##  check for Bool    - use Hash.new(False)
     if args[0].is_a? Hash
       arg = args[0].to_a   ## convert to array (for easier access)
       klass_key   = arg[0][0]
       klass_value = arg[0][1]
       klass = Safe::SafeHash.build_class( klass_key, klass_value )
       klass.new
     else
       ## todo/fix: throw argument error/exception
       Hash.new    ## that is, "plain" {} with all "standard" defaults
     end
  end
end


class Array
  ## "typed" safe array "constructor"
  ## e.g.  Array.of( Address ) or Array.of( Money ) or
  ##       Array.of( Proposal, 2 ) etc.
  def self.of( klass_value, size=0 )
    klass = Safe::SafeArray.build_class( klass_value )
    klass.new( size )
  end
end



module Safe
  ############################
  # note: HACK redefine built in struct in module Safe "context"
  ClassicStruct = ::Struct        ## save old classic struct class
  Struct        = SafeStruct
end

puts Safe.banner    ## say hello
