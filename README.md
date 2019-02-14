# Safe Data Structures (Array, Hash, Struct)

safestruct gem / library - safe data structures (array, hash, struct) - say goodbye to null / nil (and maybe) - say hello to zero

* home  :: [github.com/s6ruby/safestruct](https://github.com/s6ruby/safestruct)
* bugs  :: [github.com/s6ruby/safestruct/issues](https://github.com/s6ruby/safestruct/issues)
* gem   :: [rubygems.org/gems/safestruct](https://rubygems.org/gems/safestruct)
* rdoc  :: [rubydoc.info/gems/safestruct](http://rubydoc.info/gems/safestruct)
* forum :: [wwwmake](http://groups.google.com/group/wwwmake)


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

**All variables - including structs, arrays and mappings (hash dictionaries) -  
MUST ALWAYS get set (initialized) to ZERO (default) values.**

What's zero?

| Type           | Value                      |
|----------------|----------------------------|
| Integer        | `0`      or `Integer.zero` |
| Bool           | `false`  or `Bool.zero`    |
| String         | `''` or `String.zero`      |
| Array          | `[]` or `Array.zero`       |
| Mapping (Hash) | `{}` or `Mapping.zero`     |
| Vote (Struct)  | `Vote.new( 0, false, 0, '0x0000')` or `Vote.zero`  |
| Address        | `0x0000` or `Address.zero` or `Address(0)`         |
| ...            |                                                    |


### Safe Struct

Let's you define (auto-build) new struct classes.
Example:

``` ruby
Voter = SafeStruct.new( weight: 0, voted: false, vote: 0, delegate: '0x0000' )

voter1 = Voter.new    # or Voter.new_zero
pp voter1.weight      #=> 0
pp voter1.voted       #=> false
pp voter1.vote        #=> 0
pp voter1.delegate    #=> '0x0000'
pp voter1.frozen?     #=> false

pp voter1 == Voter.zero    #=> true

pp voter1.delegate = '0x1111'
pp voter1 == Voter.zero    #=> false
 
voter2 = Voter.new( 0, false, 0, '0x0000')  

pp voter2.voted    = true
pp voter2.delegate = '0x2222'
pp voter2 == Voter.zero    #=> false

pp Voter.zero.frozen?      #=> true
```

Note: You can use `Struct` as an alias for `SafeStruct`.


### Safe Array

Let's you define (auto-build) new (type safe) array classes.
Example:

``` ruby
ArrayInteger = SafeArray.build_class( Integer )
ary = ArrayInteger.new

pp ary[0] #=> 0
```

or use the `Array.of` convenience shortcut:

``` ruby
ary = Array.of( Integer )

pp ary[0]  #=> 0

## or

another_ary = Array.of( Bool )

pp another_ary[0]  #=> false
```

Note: Safe Array works with structs (or nested arrays or mappings) too. Example:

``` ruby
ary = Array.of( Vote )

pp ary[0]         #=> #<Vote @weight=0, @voted=false, @vote=0, @delegate='0x0000'> 
pp ary[0].voted?  #=> false
```


### Safe Hash

Let's you define (auto-build) new (type safe) hash classes.
Example:

``` ruby
Hash_X_Integer = SafeHash.build_class( String, Integer )
hash = Hash_X_Integer.new

pp hash['0x0000']  #=> 0
```

or use the `Mapping.of` convenience shortcut:

``` ruby
hash = Mapping.of( String => Integer )

pp hash['0x0000']  #=> 0
```


Note: Safe Hash works with structs (or arrays or nested mappings) too. Example:

``` ruby
hash = Mapping.of( String => Vote )

pp hash['0x0000']          #=> #<Vote @weight=0, @voted=false, @vote=0, @delegate='0x0000'> 
pp hash['0x0000'].voted?   #=> false
```



## License

The `safestruct` scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.


## Questions? Comments?

Send them along to the [wwwmake forum](http://groups.google.com/group/wwwmake).
Thanks!
