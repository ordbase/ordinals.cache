# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_array.rb


require 'helper'


class TestArray < MiniTest::Test

  include Safe

  Array_Integer = SafeArray.build_class( Integer )
  Array_Bool    = SafeArray.build_class( Bool )

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


end # class TestArray
