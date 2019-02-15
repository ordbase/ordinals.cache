# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_struct.rb


require 'helper'


class TestStruct < MiniTest::Test

include Safe

## sig: [Integer, Bool, Integer, Address]
Voter = SafeStruct.new( weight: 0, voted: false, vote: 0, delegate: '0x0000' )

## sig: [Address, Integer, Integer, Money]
Bet   = SafeStruct.new( user: '0x0000', block: 0, cap: 0, amount: 0 )


def test_voter
  assert_equal Voter.zero, Voter.zero
  assert_equal '0x0000',   Voter.zero.delegate
  assert_equal false,      Voter.zero.voted?
  assert_equal 0,          Voter.zero.weight
  assert_equal 0,          Voter.zero.vote
  assert_equal true,       Voter.zero.frozen?

  voter = Voter.new_zero

  assert_equal false,      voter.frozen?
  assert_equal Voter.zero, voter
  assert       Voter.zero == voter
  assert       Voter.zero.eql?( voter )

  voter.delegate = '0x1111'
  pp voter

  assert       Voter.zero != voter

  voter2 = Voter.new( 0, false, 0, '0x0000' )
  assert_equal Voter.zero, voter2
  assert_equal false,      voter2.frozen?
end

def test_bet
  pp Bet
  bet = Bet.new_zero
  pp bet

  assert_equal Bet.zero, bet

  bet.cap    = 20_000
  bet.amount = 100

  assert_equal false,  bet.frozen?
  assert_equal 20_000, bet.cap
  assert_equal 100,    bet.amount
  assert       Bet.zero != bet

  pp bet

  pp Bet.zero
  pp Bet.zero

  assert_equal Bet.zero,   Bet.zero
  assert_equal '0x0000',   Bet.zero.user
  assert_equal 0,          Bet.zero.block
  assert_equal 0,          Bet.zero.cap
  assert_equal 0,          Bet.zero.amount
  assert_equal true,       Bet.zero.frozen?

  bet2 = Bet.new( '0x0000', 0, 0, 0 )
  assert_equal Bet.zero, bet2
  assert_equal false,    bet2.frozen?
end

end # class TestStruct
