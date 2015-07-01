
# Standard Library (stdlib)

A collection of awesome Ruby standard libraries and alternatives

[abbrev](#abbrev) •
[base64](#base64)

## abbrev

_Calculates a set of unique abbreviations for a given set of strings_

- [abbrev.rb](https://github.com/ruby/ruby/blob/trunk/lib/abbrev.rb)

~~~
Abbrev.abbrev(['ruby'])
  #=>  {"ruby"=>"ruby", "rub"=>"ruby", "ru"=>"ruby", "r"=>"ruby"}
~~~

## base64

_Support for encoding and decoding binary data using a Base64 representation_

- [base64.rb](https://github.com/ruby/ruby/blob/trunk/lib/base64.rb)

~~~
enc   = Base64.encode64('Send reinforcements')
          #=> "U2VuZCByZWluZm9yY2VtZW50cw==\n"
plain = Base64.decode64(enc)
          #=> "Send reinforcements"
~~~

