
# Standard Library (StdLib)

A collection of awesome Ruby standard libraries and alternatives

Note: :octocat: stands for the GitHub page and :gem: for the RubyGems page.

---

[ANNOUNCEMENT] Looking for awesome Ruby Gems? See the [Ruby Gems of the Week Series @ Planet Ruby](http://planetruby.github.io/gems).

---

Contributions welcome. Anything missing? Send in a pull request. Thanks.

[abbrev](#abbrev) •
[base64](#base64) •
[benchmark](#benchmark) •
[cgi](#cgi) • 
[cmath](#cmath) •
[csv](#csv)

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
Benchmark.measure { "a"*1_000_000_000 }
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

- [benchmark-ips :octocat:](https://github.com/evanphx/benchmark-ips), [:gem:](https://rubygems.org/gems/benchmark-ips) - a iterations per second enhancement to benchmark by Evan Phoenix

## cgi

_Support for the Common Gateway Interface (CGI) protocol for passing an HTTP request from a web server to a standalone program, and returning the output to the web browser_

- [cgi.rb](https://github.com/ruby/ruby/blob/trunk/lib/cgi.rb)

~~~
params = CGI.parse("query_string")
  #=> {"name1" => ["value1", "value2", ...],
       "name2" => ["value1", "value2", ...], ... }

CGI.escapeHTML('Usage: foo "bar" <baz>')
  #=>

cgi = CGI.new("html4")
cgi.out do
  cgi.html do
    cgi.head do
      cgi.title { "TITLE" }
    end +
    cgi.body do
      cgi.p { "TEXT" }
    end
  end
end 
  #=>
~~~

Alternatives:

- [rack :octocat:](https://github.com/rack/rack), [:gem:](https://rubygems.org/gems/rack) - a modular Ruby webserver interface by Christian Neukirchen, Aaron Patterson et al

## cmath

_Provides Trigonometric and Transcendental functions for complex numbers_

- [cmath.rb](https://github.com/ruby/ruby/blob/trunk/lib/cmath.rb)
 
~~~
CMath.log(1 + 4i)     #=> (1.416606672028108+1.3258176636680326i)
CMath.log(1 + 4i, 10) #=> (0.6152244606891369+0.5757952953408879i)
CMath.sqrt(-1 + 0i)   #=> 0.0+1.0i
CMath.sin(1 + 1i)     #=> (1.2984575814159773+0.6349639147847361i)
~~~

## csv

_Provides an interface to read and write Comma-Separated Values (CSV) files and data _

- [csv.rb](https://github.com/ruby/ruby/blob/trunk/lib/csv.rb)

~~~
CSV.read('customers.csv')
#=> ["Dan", "34", "2548", "Lovin it!"]
   ["Maria", "55", "5054", "Good, delicious food"]

str = "Dan,34\nMaria,55"
CSV.parse( str ) 
#=> [["Dan", "34"], ["Maria", "55"]]
~~~

Articles:

- [A Guide to the Ruby CSV Library, Part I](http://www.sitepoint.com/guide-ruby-csv-library-part/) by Darko Gjorgjievski; SitePoint; January 2014
- [A Guide to the Ruby CSV Library, Part II](http://www.sitepoint.com/guide-ruby-csv-library-part-2/) by Darko Gjorgjievski; SitePoint; March 2014



## Meta

**License**

The awesome list is dedicated to the public domain. Use it as you please with no restrictions whatsoever.

**Questions? Comments?**

Send them along to the ruby-talk mailing list. Thanks!
