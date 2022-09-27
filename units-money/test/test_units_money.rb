# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_units_money.rb


require 'helper'


class TestUnitsMoney < MiniTest::Test

def test_exponential
  assert_equal 1_000_000_000_000_000_000, 1.e18
  assert_equal 1_000_000_000_000_000,     1.e15
  assert_equal 1_000_000_000_000,         1.e12
  assert_equal 1_000_000_000,             1.e9
  assert_equal 1_000_000,                 1.e6
  assert_equal 1_000,                     1.e3

  assert_equal 1_000_000_000_000_000_000, Integer::E18
  assert_equal 1_000_000_000_000_000,     Integer::E15
  assert_equal 1_000_000_000_000,         Integer::E12
  assert_equal 1_000_000_000,             Integer::E9
  assert_equal 1_000_000,                 Integer::E6
  assert_equal 1_000,                     Integer::E3
end


def test_ether
  pp Integer.ancestors.inspect

  value = rand( 1_000_000_000 )

  assert_equal 1_000_000_000_000_000_000,       1.ether
  assert_equal 1_000_000_000_000_000_000,       1.eth
  assert_equal 1_000_000_000_000_000_000*2,     1.ether*2
  assert_equal value+1_000_000_000_000_000_000, value+1.ether

  assert_equal 1_000_000_000_000_000,       1.milliether
  assert_equal 1_000_000_000_000_000,       1.millieth
  assert_equal 1_000_000_000_000_000,       1.milli
  assert_equal 1_000_000_000_000_000,       1.finney
  assert_equal 1_000_000_000_000_000*2,     1.milliether*2
  assert_equal value+1_000_000_000_000_000, value+1.milliether

  assert_equal 1_000_000_000_000,       1.microether
  assert_equal 1_000_000_000_000,       1.microeth
  assert_equal 1_000_000_000_000,       1.micro
  assert_equal 1_000_000_000_000,       1.szabo
  assert_equal 1_000_000_000_000*2,     1.microether*2
  assert_equal value+1_000_000_000_000, value+1.microether

  assert_equal 1_000_000_000,       1.gwei
  assert_equal 1_000_000_000,       1.shannon
  assert_equal 1_000_000_000*2,     1.gwei*2
  assert_equal value+1_000_000_000, value+1.gwei

  assert_equal 1_000_000,       1.mwei
  assert_equal 1_000_000,       1.lovelace
  assert_equal 1_000_000*2,     1.mwei*2
  assert_equal value+1_000_000, value+1.mwei

  assert_equal 1_000,       1.kwei
  assert_equal 1_000,       1.babbage
  assert_equal 1_000*2,     1.kwei*2
  assert_equal value+1_000, value+1.kwei
end

end # class TestUnitsMoney
