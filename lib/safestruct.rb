# encoding: utf-8

require 'pp'
require 'forwardable'     # uses def_delegator

## 3rd party libs
require 'enums'

## our own code
require 'safestruct/version'    # note: let version always go first


require 'safestruct/safe_array'
require 'safestruct/safe_hash'
require 'safestruct/safe_struct'



####################################
## add zero/zero_new machinery for builin classes

#########################
#### with value semantics
class Integer
  def self.zero() 0; end      ## note: 0.frozen? == true  by default
  def zero?() self == self.class.zero;  end
end


class Bool
  def self.zero() false; end   ## note: false.frozen? == true  by default
end

class TrueClass    # note: ruby has no builtin/default bool (base) class only TrueClass|FalseClass
  def zero?() false; end
end

class FalseClass
  def zero?() true; end
end

##################
#### with reference semantics (new copy ALWAYS needed)
class String
  def self.new_zero() new; end
  def self.zero() @zero ||= new_zero.freeze;  end
  def zero?() self == self.class.zero; end
end




#####
# add "beautiful" convenience helpers

class Hash

  def self.of( *args )
     ## e.g. gets passed in [{Address=>Integer}]
     ##  check for Integer - use Hash.new(0)
     ##  check for Bool    - use Hash.new(False)
     if args[0].is_a?( Hash ) && args.size == 1
       arg = args[0].to_a   ## convert to array (for easier access)
       klass_key   = arg[0][0]
       ## note: for nested Hash.of or Array.of a ("prototype") object
       ##        gets passed in (NOT class) - auto-convert to use class
       klass_or_proto_value = arg[0][1]
       klass_value = klass_or_proto_value.is_a?( Class ) ? klass_or_proto_value : klass_or_proto_value.class
       klass = Safe::SafeHash.build_class( klass_key, klass_value )
       klass.new
     else
       raise ArgumentError.new( "[Hash.of] wrong argument; expected (default) hash e.g. String => Integer" )
     end
  end
end


class Array
  ## "typed" safe array "constructor"
  ## e.g.  Array.of( Address ) or Array.of( Money ) or
  ##       Array.of( Proposal, 2 ) etc.
  def self.of( klass_or_proto_value, size=0 )
    ## note: for nested Hash.of or Array.of a ("prototype") object
    ##        gets passed in (NOT class) - auto-convert to use class
    klass_value = klass_or_proto_value.is_a?( Class ) ? klass_or_proto_value : klass_or_proto_value.class
    klass = Safe::SafeArray.build_class( klass_value, size )
    klass.new
  end
end


module Standard
  ############################
  # note: HACK redefine built in struct in module Safe "context"
  Struct = ::Struct        ## save old classic struct class
  Array  = ::Array
  Hash   = ::Hash
end
## use/add Unsafe alias too - why? why not?
Std = Standard ## add alias lets use you use Std::Struct,Std::Array, Std::Hash etc.



module Safe
  Struct = SafeStruct

  module SafeHelper
    ## add more convenience "constructor" methods
    ##   e.g. struct 'Voter', { weight: 0, voted: false, vote: 0, delegate: '0x0000'}
    ##    or  struct 'Voter', weight: 0, voted: false, vote: 0, delegate: '0x0000'
    def struct( class_name, **attributes )
      SafeStruct.new( class_name, attributes )
    end

    ### note: do NOT add helpers for
    ##   - hash( class_name, ...)  and
    ##   - array( class_name, ...) for now
    ##   why? why not? needs more testing/considerations for overloading / breaking builtin defaults
  end # module SafeHelper
end # module Safe



puts SaferStruct.banner    ## say hello
