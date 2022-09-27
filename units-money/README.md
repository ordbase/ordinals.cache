# Units of (Crypto) Money


units-money library / gem - units of (crypto) money (in integer) incl. ether / eth (finney, szabo, shannon, lovelace, babbage, wei), bitcoin / btc (satoshi), sol (terra, luna) and more

* home  :: [github.com/s6ruby/units-money](https://github.com/s6ruby/units-money)
* bugs  :: [github.com/s6ruby/units-money/issues](https://github.com/s6ruby/units-money/issues)
* gem   :: [rubygems.org/gems/units-money](https://rubygems.org/gems/units-money)
* rdoc  :: [rubydoc.info/gems/units-money](http://rubydoc.info/gems/units-money)


## Usage

[Money](#money)

The following methods are added on `Integer` (`Fixnum` and `Bignum`)
and always return another `Integer` (`Fixnum` and `Bignum`)
object (in the base money unit) for now:

### Exponential

``` ruby
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
```


### Ether

``` ruby
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
```




### Money

Note: The `Money` class  is for now just an empty "wrapper" around an integer:

``` ruby
class Money
  def self.zero() 0; end
end

## "global" converter function e.g. Money(0)
def Money( arg ) arg; end
```



## License

![](https://publicdomainworks.github.io/buttons/zero88x31.png)

The `units-money` scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.


## Questions? Comments?

Send them along to the [wwwmake forum](http://groups.google.com/group/wwwmake).
Thanks!
