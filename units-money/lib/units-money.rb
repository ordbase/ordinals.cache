# encoding: utf-8

## stdlibs
require 'pp'


## our own code
require 'units-money/version'    # note: let version always go first


################
#  note: Money class is for now just an empty "wrapper"
#
#  todo/fix:  use a true units type / class - why? why not?
class Money
  def self.zero() 0; end
end

## "global" converter function e.g.  Money(0)
def Money( arg ) arg; end



module ExponentialUnits

  E2  = 10**2   #                       100
  E3  = 10**3   #                      1000
  E4  = 10**4   #                    10_000
  E5  = 10**5   #                   100_000
  E6  = 10**6   #                 1_000_000
  E7  = 10**7   #                10_000_000
  E8  = 10**8   #               100_000_000
  E9  = 10**9   #             1_000_000_000
  E10 = 10**10  #            10_000_000_000
  E11 = 10**11  #           100_000_000_000
  E12 = 10**12  #         1_000_000_000_000
  E13 = 10**13  #        10_000_000_000_000
  E14 = 10**14  #       100_000_000_000_000
  E15 = 10**15  #     1_000_000_000_000_000
  E16 = 10**16  #    10_000_000_000_000_000
  E17 = 10**17  #   100_000_000_000_000_000
  E18 = 10**18  # 1_000_000_000_000_000_000

  def e2()  self * E2; end
  def e3()  self * E3; end
  def e4()  self * E4; end
  def e5()  self * E5; end
  def e6()  self * E6; end
  def e7()  self * E7; end
  def e8()  self * E8; end
  def e9()  self * E9; end
  def e10() self * E10; end
  def e11() self * E11; end
  def e12() self * E12; end
  def e13() self * E13; end
  def e14() self * E14; end
  def e15() self * E15; end
  def e16() self * E16; end
  def e17() self * E17; end
  def e18() self * E18; end
end # module  ExponentialUnits


module EtherUnits
  ###########
  # Ethereum money units
  #
  #  wei                     1 wei | 1
  #  kwei (babbage)        1e3 wei | 1_000
  #  mwei (lovelace)       1e6 wei | 1_000_000
  #  gwei (shannon)        1e9 wei | 1_000_000_000
  #  microether (szabo)   1e12 wei | 1_000_000_000_000
  #  milliether (finney)  1e15 wei | 1_000_000_000_000_000
  #  ether                1e18 wei | 1_000_000_000_000_000_000
  #
  #  Names in Honor:
  #   wei            => Wei Dai
  #   lovelace       => Ada Lovelace (1815-1852)
  #   babbage	       => Charles Babbage (1791-1871)
  #   shannon	       => Claude Shannon (1916-2001)
  #   szabo          => Nick Szabo
  #   finney         => Hal Finney (1956-2014)

  def wei()        self; end
  def kwei()       self * e3; end
  def mwei()       self * e6; end
  def gwei()       self * e9; end
  def microether() self * e12; end
  def milliether() self * e15; end
  def ether()      self * e18; end

  ########################################################
  ## aliases
  alias_method :babbage,   :kwei
  alias_method :lovelace,  :mwei
  alias_method :shannon,   :gwei
  alias_method :szabo,     :microether
  alias_method :finney,    :milliether

  alias_method :microeth,  :microether
  alias_method :micro,     :microether
  alias_method :millieth,  :milliether
  alias_method :milli,     :milliether
  alias_method :eth,       :ether
end


class Integer
  include ExponentialUnits
  include EtherUnits
end  # class Integer
