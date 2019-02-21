# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_array.rb


require 'helper'


class TestArray < MiniTest::Test

  include Safe

  Array_Integer = SafeArray.build_class( Integer )
  Array_Bool    = SafeArray.build_class( Bool )

  ## multi-dimensional / nested  array
  Array_Array_Integer = SafeArray.build_class( Array_Integer )


def test_push_and_clear
  ary = Array_Integer.new

  ## note: push returns array.size after adding new item
  ##   std ruby returns reference to array itself
  assert_equal 0, ary.size
  assert_equal 1, ary.push( 10 )
  assert_equal 1, ary.size

  assert_equal 2, ary.push( 20 )
  assert_equal 2, ary.size

  ary.clear
  assert_equal 0, ary.size
end

def test_integer
  pp Array_Integer
  pp ary = Array_Integer.new(2)

  assert_equal Integer, Array_Integer.klass_value
  assert_equal 0, ary[0]
  assert_equal 0, ary[1]

  ary[0] = 101
  ary[1] = 102
  assert_equal 101,  ary[0]
  assert_equal 102,  ary[1]

  assert_equal 2,     ary.size
  assert_equal 2,     ary.length
  assert_equal false, ary.frozen?

  ary.each { |item| pp item }
  ary.each_with_index { |item,i| puts "[#{i}] #{item}"}

  ary.size = 3
  assert_equal 3, ary.size
  assert_equal 0, ary[2]
  assert       Array_Integer.zero != ary

  pp Array_Integer.zero
  assert_equal true,               Array_Integer.zero.frozen?
  assert_equal Array_Integer.zero, Array_Integer.zero
  assert_equal Array_Integer.zero, Array_Integer.new

  ## check Array.of  (uses cached classes)
  assert_equal Array_Integer, Array.of( Integer ).class
end


def test_bool
  pp Array_Bool
  pp ary = Array_Bool.new(2)

  assert_equal Bool, Array_Bool.klass_value
  assert_equal false,  ary[0]
  assert_equal false,  ary[1]

  ary[0] = true
  ary[1] = true
  assert_equal true,  ary[0]
  assert_equal true,  ary[1]

  ## check Array.of  (uses cached classes)
  assert_equal Array_Bool, Array.of( Bool ).class
end

def test_array_of
    assert_equal true,  Array.is_a?( Class )

    ary = Array.of( Integer )   # note:Array.of returns a new ("prototype") object and NOT a class
    assert_equal false, ary.is_a?( Class )
    assert_equal true,  ary.class.is_a?( Class )
end

def test_multi  # nested (multi-dimensional) array
  ## todo/fix: try with size: 3  e.g. 3x3
  ##   make it work with size too!!!!!
  ##    remember size if passed in in c'tor!!!!!!

   multi = Array_Array_Integer.new
   multi.push( Array_Integer.new )
   multi[0].push( 100 )
   multi[0].push( 200 )
   multi.push( Array_Integer.new )
   multi[1].push( 300 )
   pp multi

   assert_equal 100, multi[0][0]
   assert_equal 200, multi[0][1]
   assert_equal 300, multi[1][0]

   multi[1].clear
   assert_equal 0, multi[1].size
   multi.clear
   assert_equal 0, multi.size

   ##############################################
   ## try Array.of convenience helper

   multi = Array.of( Array.of( Integer ) )
   multi.push( Array.of( Integer ) )
   multi[0].push( 100 )
   multi[0].push( 200 )
   multi.push( Array.of( Integer ) )
   multi[1].push( 300 )
   pp multi

   assert_equal 100, multi[0][0]
   assert_equal 200, multi[0][1]
   assert_equal 300, multi[1][0]

   multi[1].clear
   assert_equal 0, multi[1].size
   multi.clear
   assert_equal 0, multi.size
end

end # class TestArray
