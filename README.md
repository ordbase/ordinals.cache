
# Standard Library (stdlib)

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
[csv](#csv) •
[DEBUGGER](#) • 
[Delegator](#) • 
[DRb](#) • 
[E2MM](#) • 
[English](#) • 
[ERB](#) • 
[FileUtils](#) • 
[Find](#) • 
[Forwardable](#) • 
[GetoptLong](#) • 
[GServer](#) • 
[IPAddr](#) • 
[IRB](#) • 
[Logger](#) • 
[MakeMakefile](#) • 
[Matrix](#) • 
[MiniTest](#) • 
[Monitor](#) • 
[Mutex_m](#) • 
[Net::FTP](#) • 
[Net::HTTP](#) • 
[Net::IMAP](#) • 
[Net::POP3](#) • 
[Net::SMTP](#) • 
[Net::Telnet](#) • 
[Observable](#) • 
[OpenURI](#) • 
[Open3](#) • 
[OptionParser](#) • 
[OpenStruct](#) • 
[PP](#) • 
[PrettyPrinter](#) • 
[Prime](#) • 
[profile.rb](#) • 
[Profiler](#) • 
[PStore](#) • 
[Queue](#) • 
[Racc](#) • 
[Rake](#) • 
[rational.rb](#) • 
[RbConfig](#) • 
[RDoc](#) • 
[resolv-replace.rb](#) • 
[Resolv](#) • 
[REXML](#) • 
[Rinda](#) • 
[RSS](#) • 
[Gem](#) • 
[Scanf](#) • 
[SecureRandom](#) • 
[Set](#) • 
[Shell](#) • 
[Shellwords](#) • 
[Singleton](#) • 
[Synchronizer](#) • 
[Tempfile](#) • 
[Test::Unit](#)



## abbrev

_Calculates a set of unique abbreviations for a given set of strings_

- [abbrev.rb](https://github.com/ruby/ruby/blob/trunk/lib/abbrev.rb)

~~~
Abbrev.abbrev(['ruby'])
  #=>  {"ruby"=>"ruby", "rub"=>"ruby", "ru"=>"ruby", "r"=>"ruby"}
~~~

Articles:

- [Abbrev - Getting to Know the Ruby Standard Library Series](http://www.monkeyandcrow.com/blog/ruby_standard_library_abbrev) by Adam Sanderson; Dec 2010

## base64

_Support for encoding and decoding binary data using a Base64 representation in plain ASCII 7-bit text_

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

- [rack :octocat:](https://github.com/rack/rack), [:gem:](https://rubygems.org/gems/rack) - a modular webserver interface by Christian Neukirchen, Aaron Patterson et al

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

_Provides an interface to read and write Comma-Separated Values (CSV) files and data_

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


## DEBUGGER

_Debugging functionality_

## Delegator

_Provides three abilities to delegate method calls to an object_

## DRb

_Distributed object system_

## E2MM

_Module for defining custom exceptions with specific messages_

## english

_Reference global variables with less cryptic names_

## ERB

_An easy to use but powerful templating system_

## FileUtils

_Several file utility methods for copying, moving, removing, etc_

## Find

_This module supports top-down traversal of a set of file paths_

## Forwardable

_Provides delegation of specified methods to a designated object_

## GetoptLong

_Parse command line options similar to the GNU C getopt\_long()_

## GServer

_HTTP server with logging, thread pooling and multi-server management_

## IPAddr ##

_Provides methods to manipulate IPv4 and IPv6 IP addresses_

## IRB ##

_Interactive Ruby command-line tool for REPL (Read Eval Print Loop)_

## Logger

_Provides a simple logging utility for outputing messages_

## MakeMakefile

_Module used to generate a Makefile for C extensions_

## Matrix

_Represents a mathematical matrix_

## MiniTest

_A test suite with TDD, BDD, mocking and benchmarking_

## Monitor

_Provides an object or module to use safely by more than one thread_

## Mutex_m

_Mixin to extend objects to be handled like a Mutex_

## Net::FTP

_Support for the File Transfer Protocol_

## Net::HTTP

_HTTP client api_

## Net::IMAP

_Client api for Internet Message Access Protocol_

## Net::POP3

_Client library for POP3_

## Net::SMTP

_Simple Mail Transfer Protocol client library_

## Net::Telnet

_Telnet client library_

## Observable

_Provides a mechanism for publich/subscribe pattern_

## OpenURI

_An easy-to-use wrapper for Net::HTTP, Net::HTTPS and Net::FTP_

## Open3

_Provides access to stdin, stdout and stderr when running other programs_

## OptionParser

_Ruby-oriented class for command-line option analysis_

## OpenStruct

_Class to build custom data structures, similar to a Hash_

## PP

_Provides a PrettyPrinter for objects_

## PrettyPrinter

_Implements a pretty printing algorithm for readable structure_

## Prime

_Prime numbers and factorization library_

## profile.rb

_Runs the Profiler_

## Profiler

_Provides a way to profile your pplication_

## PStore

_Implements a file based persistence mechanism based on a Hash_

## Queue

_Synchronized communication between threads, provided by thread.rb_

## Racc

_A LALR(1) parser generator_

## Rake

_Build program with capabilities similar to make_

## RbConfig

_Information of your configure and build of Ruby_

## RDoc

_Produces HTML and command-line documentation for Ruby_

## resolv-replace.rb

_Replace Socket DNS with Resolv_

## Resolv

_Thread-aware DNS resolver library_

## REXML

_An XML toolkit_

## Rinda

_The Linda distributed computing paradigm_

## RSS

_Family of libraries that support various formats of XML "feeds"_

## Gem

_Package management framework_

## Scanf

_A implementation of the C function scanf(3)_

## SecureRandom

_Interface for secure random number generator_

## Set

_Provides a class to deal with collections of unordered, unique values_

## Shell

_An idiomatic interface for common UNIX shell commands_

## Shellwords

_Manipulates strings with word parsing rules of UNIX Bourne shell_

## Singleton

_Implementation of the Singleton pattern_

## Synchronizer

_A module that provides a two-phase lock with a counter_

## Tempfile

_A utility class for managing temporary files_

## Test::Unit

_A compatibility layer for MiniTest_

## Thread

_Provides support classes for threaded programs_

## ThreadsWait

_Watches for termination of multiple threads_

## Time

_Extends the Time class with methods for parsing and conversion_

## Timeout

_Auto-terminate potentially long-running operations_

## tmpdir.rb

_Extends the Dir class to manage the OS temporary file path_

## Tracer

_Outputs a source level execution trace of a Ruby program_

## TSort

_Topological sorting using Tarjan’s algorithm_

## un.rb

_Utilities to replace common UNIX commands_

## URI

_Pproviding support for Uniform Resource Identifiers (URIs)_

## WeakRef

_Allows a referenced object to be garbage-collected_

## WEBrick

_An HTTP server toolkit_

## XMLRPC

_Remote Procedure Call over HTTP support_

## YAML

_Client library for the Psych YAML implementation_





## Meta

**License**

The awesome list is dedicated to the public domain. Use it as you please with no restrictions whatsoever.

**Questions? Comments?**

Send them along to the ruby-talk mailing list. Thanks!
