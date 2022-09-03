# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_u.rb


require 'helper'


class TestU < MiniTest::Test

  def test_u32
     assert U32(0) == U32.new(0)
     assert U32(0) == U32.zero
     assert U32(0) == 0.u32

     assert U32(0).zero?
     assert U32.new(0).zero?
     assert U32.zero.zero?
     assert 0.u32.zero?

     assert_equal false, U32(1).zero?
     assert_equal false, U32.new(1).zero?
     assert_equal false, U32(1) == U32(2)

     ## allow compare with "untagged" integer - why? why not?
     assert_equal false, U32(0) == 0

     assert_equal U32(4), U32(2)+U32(2)
     assert_equal U32(4), 2.u32+2.u32
     assert_equal U32(4), U32(2)+2

     assert_equal U32(2), U32(4)-U32(2)
     assert_equal U32(2), 4.u32-2.u32
     assert_equal U32(2), U32(4)-2
  end

end  # class TestU
