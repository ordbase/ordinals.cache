# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_hash.rb


require 'helper'


class TestHash < MiniTest::Test

  include Safe

  ## sig: [Integer, Bool, Integer, Address]
  Voter = SafeStruct.new( weight: 0, voted: false, vote: 0, delegate: '0x0000' )

  Hash_X_Integer = SafeHash.build_class( String, Integer )
  Hash_X_Bool    = SafeHash.build_class( String, Bool )
  Hash_X_Voter   = SafeHash.build_class( String, Voter )

def test_integer
  pp Hash_X_Integer
  pp h = Hash_X_Integer.new

  assert_equal false, h.key?( '0x1111' )
  assert_equal false, h.has_key?( '0x1111' )

  ## todo/fix: remove size and length for (safe) hash - why? why not?
  assert_equal 0, h.size
  assert_equal 0, h.length

  assert_equal Hash_X_Integer.zero, h
  assert_equal Hash_X_Integer.zero, Hash_X_Integer.new

  pp Hash_X_Integer.zero
  assert_equal true,   Hash_X_Integer.zero.frozen?
  assert_equal false,  Hash_X_Integer.new.frozen?
  assert_equal false,  h.frozen?

  
  assert_equal Integer, Hash_X_Integer.klass_value
  assert_equal 0,  h['0x1111']
  assert_equal 0,  h['0x2222']

  h['0x1111'] = 101
  h['0x2222'] = 102
  assert_equal 101,  h['0x1111']
  assert_equal 102,  h['0x2222']

  ## check Hash.of  (uses cached classes)
  assert_equal Hash_X_Integer, Hash.of( String => Integer ).class
end


def test_bool
  pp Hash_X_Bool
  pp h = Hash_X_Bool.new

  assert_equal Bool, Hash_X_Bool.klass_value
  assert_equal false,  h['0x1111']
  assert_equal false,  h['0x2222']

  h['0x1111'] = true
  h['0x2222'] = true
  assert_equal true,  h['0x1111']
  assert_equal true,  h['0x2222']

  ## check Hash.of  (uses cached classes)
  assert_equal Hash_X_Bool, Hash.of( String => Bool ).class
end


def test_voter
  pp Hash_X_Voter
  pp h = Hash_X_Voter.new

  assert_equal Voter, Hash_X_Voter.klass_value
  assert_equal Voter.zero, h['0x1111']
  assert_equal Voter.zero, h['0x2222']

  h['0x1111'].voted = true
  h['0x2222'].voted = true
  assert_equal true,  h['0x1111'].voted?
  assert_equal true,  h['0x2222'].voted?

  pp h['0x1111']
  pp h['0x2222']

  ## check Hash.of  (uses cached classes)
  assert_equal Hash_X_Voter, Hash.of( String => Voter ).class
end


end # class TestHash
