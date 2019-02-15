# Safe Data Structures (Array, Hash, Struct)

safestruct gem / library - safe data structures (array, hash, struct) - say goodbye to null / nil (and maybe) - say hello to zero

* home  :: [github.com/s6ruby/safestruct](https://github.com/s6ruby/safestruct)
* bugs  :: [github.com/s6ruby/safestruct/issues](https://github.com/s6ruby/safestruct/issues)
* gem   :: [rubygems.org/gems/safestruct](https://rubygems.org/gems/safestruct)
* rdoc  :: [rubydoc.info/gems/safestruct](http://rubydoc.info/gems/safestruct)


## Usage

[Safe Struct](#safe-struct)  •
[Safe Array](#safe-array)  •
[Safe Hash](#safe-hash)


### Null / Nil - The Billion Dollar Mistake ++ Zero - The Billion Dollar Fix

> I call it my billion-dollar mistake. It was the invention of the null reference in 1965.
> At that time, I was designing the first comprehensive type system for references
> in an object oriented language (ALGOL W).
> My goal was to ensure that all use of references should be absolutely safe,
> with checking performed automatically by the compiler.
> But I couldn't resist the temptation to put in a null reference,
> simply because it was so easy to implement.
> This has led to innumerable errors, vulnerabilities, and system crashes,
> which have probably caused a billion dollars of pain and damage in the last forty years.
>
> -- [Sir Tony Hoare](https://en.wikipedia.org/wiki/Tony_Hoare)


Let's make the code safer and
let's say goodbye to null / nil (and maybe).
How can the code work without nil?


Let's say hello to zero.
The new rule for NO null/nil ever (again) is:

**All variables - including structs, arrays and hash mappings -
MUST ALWAYS get set (initialized) to ZERO (default) values.**

What's zero?

| Type           | Value                      |
|----------------|----------------------------|
| Integer        | `0`      or `Integer.zero` |
| Bool           | `false`  or `Bool.zero`    |
| String         | `''` or `String.zero`      |
| Array          | `[]` or `Array.zero`       |
| Hash           | `{}` or `Hash.zero`        |
| Vote (Struct)  | `Vote.new( 0, false, 0, '0x0000')` or `Vote.zero`  |
| Address        | `0x0000` or `Address.zero` or `Address(0)`         |
| ...            |                                                    |


### Safe Struct

Let's you define (auto-build) new struct classes.
Example:

``` ruby
Voter = SafeStruct.new( weight: 0, voted: false, vote: 0, delegate: '0x0000' )

voter1 = Voter.new    # or Voter.new_zero
voter1.weight      #=> 0
voter1.voted?      #=> false
voter1.vote        #=> 0
voter1.delegate    #=> '0x0000'
voter1.frozen?     #=> false

voter1 == Voter.zero    #=> true

voter1.delegate = '0x1111'
voter1 == Voter.zero    #=> false

voter2 = Voter.new( 0, false, 0, '0x0000')  

voter2.voted    = true
voter2.delegate = '0x2222'
voter2 == Voter.zero     #=> false

Voter.zero.frozen?       #=> true

voter3 = Voter.new( 0 )  #=> ArgumentError: wrong number of arguments
                         #     for Voter.new - 1 for 4
```


Note: You can use `Struct` as an alias for `SafeStruct`
(in the `Safe` namespace / module context).


### Safe Array

Let's you define (auto-build) new (type safe) array classes.
Example:

``` ruby
ArrayInteger = SafeArray.build_class( Integer )
ary = ArrayInteger.new
ary.size       #=> 0
ary[0]         #=> IndexError: index 0 outside of array bounds
ary.size = 2   #=> [0,0]
ary[0]         #=> 0
```

or use the `Array.of` convenience shortcut:

``` ruby
ary = Array.of( Integer )
ary.size       #=> 0
ary[0]         #=> IndexError: index 0 outside of array bounds
ary.size = 2   #=> [0, 0]
ary[0]         #=> 0

## or

another_ary = Array.of( Bool )
another_ary.size      #=> 0
another_ary[0]        #=> IndexError: index 0 outside of array bounds
another_ary.size = 2  #=> [false, false]
another_ary[0]        #=> false

## or

another_ary = Array.of( Bool, 2 )
another_ary.size      #=> 2
another_ary[0]        #=> false
```

Yes, Safe Array works with structs (or nested arrays or hash mappings) too. Example:

``` ruby
ary = Array.of( Vote )

ary[0]         #=> IndexError: index 0 outside of array bounds
ary.size = 2   #=> [#<Vote @weight=0, @voted=false, @vote=0, @delegate='0x0000'>,
               #    #<Vote @weight=0, @voted=false, @vote=0, @delegate='0x0000'>]
ary[0]         #=> #<Vote @weight=0, @voted=false, @vote=0, @delegate='0x0000'>
ary[0].voted?  #=> false
```


### Safe Hash

Let's you define (auto-build) new (type safe) hash classes.
Example:

``` ruby
Hash_X_Integer = SafeHash.build_class( String, Integer )
hash = Hash_X_Integer.new

hash['0x0000']  #=> 0
```

or use the `Hash.of` convenience shortcut:

``` ruby
hash = Hash.of( String => Integer )

hash['0x0000']         #=> 0
hash['0x0000'] += 42
hash['0x0000']         #=> 42
```

Note: Safe Hash will ALWAYS return a value.
If the key is missing in the hash mapping on lookup,
the key gets auto-added with a zero value.
Use `has_key?` or `key?` to check if a key is present.


Yes, Safe Hash works with structs (or arrays or nested hash mappings) too. Example:

``` ruby
hash = Hash.of( String => Vote )

hash['0x0000']                #=> #<Vote @weight=0, @voted=false, @vote=0, @delegate='0x0000'>
hash['0x0000'].voted?         #=> false
hash['0x0000'].voted = true
hash['0x0000'].voted?         #=> true
```




## More "Real World" Safe Data Structures (Array, Hash, Struct) Samples

- [The "Red Paper" about sruby](https://github.com/s6ruby/redpaper) - Small, Smart, Secure, Safe, Solid & Sound (S6) Ruby - The Ruby Programming Language for Contract / Transaction Scripts on the Blockchain World Computer - Yes, It's Just Ruby
- [Programming Crypto Blockchain Contracts Step-by-Step Book / Guide](https://github.com/s6ruby/programming-cryptocontracts). Let's Start with Ponzi & Pyramid Schemes. Run Your Own Lotteries, Gambling Casinos and more on the Blockchain World Computer...
- [Ruby Sample Contracts for the Universum Blockchain/World Computer Runtime](https://github.com/s6ruby/universum-contracts)



## License

![](https://publicdomainworks.github.io/buttons/zero88x31.png)

The `safestruct` scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.


## Questions? Comments?

Send them along to the [wwwmake forum](http://groups.google.com/group/wwwmake).
Thanks!
