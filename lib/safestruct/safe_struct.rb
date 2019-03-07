# encoding: utf-8

module Safe

class SafeStruct


def self.convert( arg )
  ## note: for now only supports 0 for Vote(0) as Vote.zero shortcut
  if arg == 0
    zero
  else
    raise ArgumentError.new( "[SafeStruct] invalid argument #{arg} - cannot convert to #{name}" )
  end
end


def self.build_class( class_name, **attributes )

 ## todo/fix:
 ## check if valid class_name MUST start with uppercase letter etc.
 ##  todo/fix: check if constant is undefined in Safe namespace!!!!

  
  klass = Class.new( SafeStruct ) do
    define_method( :initialize ) do |*args|
      attributes.keys.zip( args ).each do |key, arg|
        instance_variable_set( "@#{key}", arg )
      end
      self  ## note: return reference to self for chaining method calls
    end

    attributes.each do |key,value|
      define_method( key ) do
        instance_variable_get( "@#{key}" )
      end
      if value == false  ## note: for Bool add getter with question mark (e.g. voted? etc.)
        define_method( "#{key}?" ) do
          instance_variable_get( "@#{key}" )
        end
      end
      define_method( "#{key}=" ) do |arg|
        instance_variable_set( "@#{key}", arg )
      end
    end

    alias_method :old_freeze, :freeze   # note: store "old" orginal version of freeze
    define_method( :freeze ) do
      old_freeze    ## same as calling super
      attributes.keys.each do |key|
        instance_variable_get( "@#{key}" ).freeze
      end
      self   # return reference to self
    end

    define_method( :== ) do |other|
       if other.is_a?( klass )
         attributes.keys.all? do |key|
           __send__( key ) == other.__send__( key )
         end
       else
         false
       end
    end
    alias_method :eql?, :==
  end

  ## add self.new too - note: call/forward to "old" orginal self.new of Event (base) class
  klass.define_singleton_method( :new ) do |*args|
    if args.empty?  ## no args - use new_zero and set (initialize) all ivars to zero
      new_zero
    else
      if args.size != attributes.size
        ## check for required args/params - all MUST be passed in!!!
        raise ArgumentError.new( "[SafeStruct] wrong number of arguments for #{name}.new - #{args.size} for #{attributes.size}" )
      end
      old_new( *args )
    end
  end

  klass.define_singleton_method( :new_zero ) do
    ## note: if attribute value is a composite
    ##     use new_zero to create a new instance!!!
    ##     do NOT use the passed in reference!!!!
    values = attributes.values.map do |value|
      ## note: was: use more "generic" check for respond_to?( :new_zero )
      ##  value.is_a?(SafeStruct) ||
      ##  value.is_a?(SafeArray)  ||
      ##  value.is_a?(SafeHash)
      if value.is_a?(String) && value == '0x0000'
        value.dup    ## special case for Address(0) or Address.zero encoded as string for now!!!!
      elsif value.class.respond_to?( :new_zero )
        value.class.new_zero
      else
        ## assume "value" object / semantics (e.g. 0, false, '0x0000' etc.) and pass through
        value
      end
    end
    old_new( *values )
  end


  ## note: use Object for "namespacing"
  ##   make all enums convenience converters (always) global
  ##     including uppercase methods (e.g. State(), Color(), etc.) does NOT work otherwise (with other module includes)

  ## add global convenience converter function
  ##  e.g. Vote(0) is same as Vote.convert(0)
  Object.class_eval( <<RUBY )
    def #{class_name}( arg )
       #{class_name}.convert( arg )
    end
RUBY

 ## note: use Safe (module) and NOT Object for namespacing
 ##   use include Safe to make all structs global
  Safe.const_set( class_name, klass )   ## returns klass (plus sets global constant class name)
end # method build_class

class << self
  alias_method :old_new, :new       # note: store "old" orginal version of new
  alias_method :new,     :build_class    # replace original version with create
end

def self.zero
  ## note: freeze return new zero (for "singelton" & "immutable" zero instance)
  ##  todo/fix:
  ##   in build_class add freeze for composite/reference objects
  ##     that is, arrays, hash mappings, structs etc.
  ##   freeze only works for now for "value" objects e.g. integer, bool, etc.
  @zero ||= new_zero.freeze
end
end # class SafeStruct
end # module Safe
