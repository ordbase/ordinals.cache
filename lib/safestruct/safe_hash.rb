# encoding: utf-8

module Safe

class SafeHash

  ## e.g.
  ##  Hash.of( Address => Money )

  ##   note: need to create new class!! for every safe hash
  ##     make klass_key class and
  ##          klass_value class  into class instance variables
  ##     that can get used by zero
  ##       self.new returns a Hash.new/SafeHash.new like object

  def self.build_class( klass_key, klass_value )
    ## note: care for now only about value type / class

    ## note: keep a class cache
    cache = @@cache ||= {}
    klass = cache[ klass_value ]
    return klass   if klass

    klass = Class.new( SafeHash )
    klass.class_eval( <<RUBY )
      def self.klass_key
        @klass_key   ||= #{klass_key}
      end
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
    ## todo/check: if hash works if value is a (nested) hash
    @h  = {}
  end


  def []=(key, value)
    @h[key] = value
  end

  def [](key)
    item = @h[ key ]
    if item.nil?
      ## pp self.class.klass_value
      ## pp self.class.klass_value.zero

      #####
      # todo/check:
      #    add zero to hash on lookup (increases size/length)
      #    why? why not?

      if self.class.klass_value.respond_to?( :new_zero )
        ## note: use a dup(licated) unfrozen copy of the zero object
        ##    changes to the object MUST be possible (new "empty" modifable object expected)
       item = @h[ key ] = self.class.klass_value.new_zero
     else  # assume value semantics e.g. Integer, Bool, etc. zero values gets replaced
       ## puts "use value semantics"
       item = @h[ key ] = self.class.klass_value.zero
     end
    end
    item
  end

  def size() @h.size; end
  def length() size; end
end # class SafeHash
end # module Safe
