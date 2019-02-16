# encoding: utf-8

module Safe

class SafeArray

  ## e.g.
  ##  Array.of( Address ), Array.of( Integer), etc.

  def self.build_class( klass_value )
    ## note: care for now only about value type / class

    ## note: keep a class cache
    cache = @@cache ||= {}
    klass = cache[ klass_value ]

    if klass.nil?

      klass = Class.new( SafeArray )
      klass.class_eval( <<RUBY )
        def self.klass_value
          @klass_value ||= #{klass_value}
        end
RUBY
      ## add to cache for later (re)use
      cache[ klass_value ] = klass
    end
    klass
  end


  def self.new_zero()  new;  end
  def self.zero()      @zero ||= new_zero.freeze;  end



  def initialize( size=0 )
    ## todo/check: if array works if value is a (nested/multi-dimensional) array
    @ary  = []
    self.size = size   if size > 0  ## auto-init with zeros
    self   # return reference to self
  end

  def freeze
    super
    @ary.freeze  ## note: pass on freeze to "wrapped" array
    self   # return reference to self
  end


  def ==( other )
    if other.is_a?( self.class )                       ## note: must be same array class
      @ary == other.instance_variable_get( '@ary' )    ## compare "wrapped" array
    else
      false
    end
  end
  alias_method :eql?, :==


  def size=(value)
    ## todo/check: value must be greater 0 and greater than current size
    diff = value - @ary.size

    ## todo/check:
    ##    always return (deep) frozen zero object - why? why not?
    ##     let user change the returned zero object - why? why not?
    if self.class.klass_value.respond_to?( :new_zero )
      ## note: use a new unfrozen copy of the zero object
      ##    changes to the object MUST be possible (new "empty" modifable object expected)
      diff.times { @ary << self.class.klass_value.new_zero }
   else  # assume value semantics e.g. Integer, Bool, etc. zero values gets replaced
      ## puts "use value semantics"
      diff.times { @ary << self.class.klass_value.zero }
   end
   self  # return reference to self
  end
  alias_method :'length=', :'size='


  def []=(index, value)
    ## note: use fetch
    #    throws / raises an IndexError exception
    #    if the referenced index lies outside of the array bounds
    # todo/fix: is there a better way to check for index out-of-bounds error?
    old_value = @ary.fetch( index )
    @ary[index] = value
  end

  def [](index)
    ## note: throws / raises an IndexError exception
    #    if the referenced index lies outside of the array bounds
    @ary.fetch( index )
  end

  def push( item )
    ## todo/fix: check if item.is_a? @type
    ##   note: Address might be a String too (Address | String)
    ##     store Address always as String!!! - why? why not?
    @ary.push( item )
  end

extend Forwardable
def_delegators :@ary, :size, :length,
                      :each, :each_with_index


end # class SafeArray
end # module Safe
