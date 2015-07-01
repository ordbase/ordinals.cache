
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

## benchmark

_Provides methods to measure and report the time used to execute code_

- [benchmark.rb](https://github.com/ruby/ruby/blob/trunk/lib/benchmark.rb)

~~~
puts Benchmark.measure { "a"*1_000_000_000 }
  #=> 0.350000   0.400000   0.750000 (  0.835234)

n = 5000000
Benchmark.bm(7) do |x|
  x.report("for:")   { for i in 1..n; a = "1"; end }
  x.report("times:") { n.times do   ; a = "1"; end }
  x.report("upto:")  { 1.upto(n) do ; a = "1"; end }
end
  #=>         user     system      total        real
for:      1.010000   0.000000   1.010000 (  1.015688)
times:    1.000000   0.000000   1.000000 (  1.003611)
upto:     1.030000   0.000000   1.030000 (  1.028098)  
~~~

Alternatives:

- [benchmark-ips :octocat:](https://github.com/evanphx/benchmark-ips) - a iterations per second enhancement to benchmark by Evan Phoenix

