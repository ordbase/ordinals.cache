# encoding: utf-8

require 'pp'

## our own code
require 'safemath/version'    # note: let version always go first



##
# todo: use a class builder for typed integers
#   what name to use for shared base class?



class U32    # unsigned integer 32-bit
  def initialize( value )
    @value=value
  end

  def ==( other )
    if other.is_a?( self.class )
      @value == other.to_i
    else
      false
    end
  end
  alias_method :eql?, :==



  def +( other )
    if other.is_a?( self.class )
      self.class.new( @value + other.to_i )
    elsif other.is_a?( Integer )   ## in relax (non-strict) mode allow "untagged" integers
      self.class.new( @value + other )
    else
      raise TypeError.new( "[U32] add(ition) - wrong type >#{other.inspect}< #{other.class.name} - U32 expected" )
    end
  end

  def -( other )
    if other.is_a?( self.class )
      self.class.new( @value - other.to_i )
    elsif other.is_a?( Integer )   ## in relax (non-strict) mode allow "untagged" integers
      self.class.new( @value - other )
    else
      raise TypeError.new( "[U32] sub(traction) - wrong type >#{other.inspect}< #{other.class.name} - U32 expected" )
    end
  end



  def self.convert( arg )
    ## assume integer number for now for arg
    ##   todo/fix: add support for enums
    new( arg )
  end

  def zero?() self == self.class.zero; end  ## note: compares values (e.g. 0==0) - not object_id (or frozen) etc.

  ## todo/fix: always freeze by default (u32 is immutable) - why? why not?
  def self.zero()  @@zero ||= new(0).freeze; end
  def zero?() self == self.class.zero;  end

  def to_i()   @value; end
  def to_int() @value; end
end  # class U32



####################
# "global" kernel converter methods

module Kernel
  def U32( arg ) U32.convert( arg ); end
end # module Kernel



module SafeMathIntegers
  def u32() U32.convert(self); end
end # module SafeMathIntegers

class Integer
   include SafeMathIntegers
end # class Integer


puts SaferMath.banner    ## say hello
