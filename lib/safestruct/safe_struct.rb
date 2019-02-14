# encoding: utf-8

class SafeStruct

def self.build_class( **attributes )
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

    define_method( :== ) do |other|
       return false unless other.is_a?( klass )
        attributes.keys.all? do |key|
          __send__( key ) == other.__send__( key )
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
      if value.is_a?(SafeStruct) ||
         value.is_a?(SafeArray)  ||
         value.is_a?(SafeHash)
         value.class.new_zero
      else
        ## assume "value" object / semantics (e.g. 0, false, '0x0000' etc.) and pass through
        value
      end
    end
    old_new( *values )
  end

  klass
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
