# encoding: utf-8

class SafeArray

  ## e.g.
  ##  Array.of( Address ), Array.of( Integer), etc.

  def self.build_class( klass_value )
    ## note: care for now only about value type / class

    ## note: keep a class cache
    cache = @@cache ||= {}
    klass = cache[ klass_value ]
    return klass   if klass

    klass = Class.new( SafeArray )
    klass.class_eval( <<RUBY )
      def self.klass_value
        @klass_value ||= #{klass_value}
      end
RUBY
    ## add to cache for later (re)use
    cache[ klass_value ] = klass
    klass
  end


  def self.new_zero()  new;  end
  def self.zero()      @zero ||= new_zero;  end



  def initialize
    ## todo/check: if array works if value is a (nested/multi-dimensional) array
    @ary  = []
  end

  def []=(index, value)
    @ary[index] = value
  end

  def [](index)
    item = @ary[ index ]
    if item.nil?
      ## todo/check:
      ##    always return (deep) frozen zero object - why? why not?
      ##     let user change the returned zero object - why? why not?
      if self.class.klass_value.respond_to?( :new_zero )
        ## note: use a new unfrozen copy of the zero object
        ##    changes to the object MUST be possible (new "empty" modifable object expected)
       item = self.class.klass_value.new_zero
     else  # assume value semantics e.g. Integer, Bool, etc. zero values gets replaced
       ## puts "use value semantics"
       item = self.class.klass_value.zero
     end
    end
    item
  end

  def push( item )
    ## todo/fix: check if item.is_a? @type
    ##   note: Address might be a String too (Address | String)
    ##     store Address always as String!!! - why? why not?
    @ary.push( item )
  end

  def size() @ary.size; end
  def length() size; end
end # class SafeArray
