# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_struct.rb


require 'helper'


## note: require voter to avoid DUPLICATE definition (with undefined state/errors etc.)
require_relative 'voter'


class TestStruct < MiniTest::Test

include Safe

## sig: [Address, Integer, Integer, Money]
## SafeStruct.new( 'Bet', user: '0x0000', block: 0, cap: 0, amount: 0 )
struct :Bet,
  user:   '0x0000',
  block:  0,
  cap:    0,
  amount: 0

## Enum.new( 'Winner', :none, :draw, :host, :challenger )
enum :Winner, :none, :draw, :host, :challenger

Board = Array_9_Integer = SafeArray.build_class( Integer, 3*3 )

## sig: [Address, Address, Address, Winner(Enum), Board(Array9)]
## SafeStruct.new( 'Game',
##                  host:       '0x0000',
##                  challenger: '0x0000',
##                  turn:       '0x0000',   ## address of host/ challenger
##                  winner:     Winner.none,  ## e.g. Winner(0)
##                  board:      Board.zero)
struct :Game,
  host:       '0x0000',
  challenger: '0x0000',
  turn:       '0x0000',   ## address of host/ challenger
  winner:     Winner.none,  ## e.g. Winner(0)
  board:      Board.zero


def test_voter
  assert_equal true,       Voter.zero.frozen?
  assert_equal true,       Voter.zero == Voter.zero

  assert_equal '0x0000',   Voter.zero.delegate
  assert_equal false,      Voter.zero.voted?
  assert_equal 0,          Voter.zero.weight
  assert_equal 0,          Voter.zero.vote

  voter = Voter.new_zero

  assert_equal false,      voter.frozen?
  assert_equal true,       Voter.zero == voter
  assert_equal true,       Voter.zero.eql?( voter )
  assert_equal true,       Voter.zero == Voter.new
  assert_equal true,       Voter.zero == Voter.new_zero


  voter.delegate = '0x1111'
  pp voter

  assert_equal false,     Voter.zero == voter

  ##############
  # try a new voter
  voter = Voter.new( 0, false, 0, '0x0000' )
  assert_equal true,      Voter.zero == voter
  assert_equal false,     voter.frozen?
end


def test_bet
  pp Bet
  assert_equal true, Bet.zero.frozen?
  assert_equal true, Bet.zero == Bet.zero


  bet = Bet.new_zero
  pp bet

  assert_equal true,   Bet.zero == bet
  assert_equal true,   Bet.zero == Bet.new
  assert_equal true,   Bet.zero == Bet.new_zero

  bet.cap    = 20_000
  bet.amount = 100

  assert_equal false,  bet.frozen?
  assert_equal 20_000, bet.cap
  assert_equal 100,    bet.amount
  assert_equal false,  Bet.zero == bet

  pp bet

  pp Bet.zero
  pp Bet.zero

  assert_equal true,       Bet.zero == Bet.zero
  assert_equal '0x0000',   Bet.zero.user
  assert_equal 0,          Bet.zero.block
  assert_equal 0,          Bet.zero.cap
  assert_equal 0,          Bet.zero.amount
  assert_equal true,       Bet.zero.frozen?

  #############################
  # try a new bet
  bet = Bet.new( '0x0000', 0, 0, 0 )
  assert_equal true,     Bet.zero == bet
  assert_equal false,    bet.frozen?
end

def test_game
  pp Game
  assert_equal true, Game.zero.frozen?
  assert_equal true, Game.zero == Game.zero

  game = Game.new_zero
  pp game

  assert_equal true,        Game.zero == game
  assert_equal true,        Game.zero == Game.new
  assert_equal true,        Game.zero == Game.new_zero
  assert_equal false,       game.frozen?

  assert_equal '0x0000',    game.host
  assert_equal '0x0000',    game.challenger
  assert_equal '0x0000',    game.turn
  assert_equal Winner.none, game.winner
  assert_equal true,        game.winner.none?
  assert_equal Board.zero,  game.board
  assert_equal 9,           game.board.size
  assert_equal 0,           game.board[0]
  assert_equal 0,           game.board[1]
  assert_equal 0,           game.board[2]
  assert_equal 0,           game.board[3]
  assert_equal 0,           game.board[4]
  assert_equal 0,           game.board[5]
  assert_equal 0,           game.board[6]
  assert_equal 0,           game.board[7]
  assert_equal 0,           game.board[8]


  game.winner = Winner.host
  assert_equal false, Game.zero == game
  pp game

  #####
  # try a new game
  game = Game.new
  game.board[0] = 1
  assert_equal false, Game.zero == game
  pp game
end


end # class TestStruct
