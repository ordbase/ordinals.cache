require 'hoe'
require './lib/safemath/version.rb'

Hoe.spec 'safemath' do

  self.version = SaferMath::VERSION

  self.summary = "safemath - safe math operations (with overflow 'n' underflow protection) on signed and unsigned integer number types (U8, U16, U32, U64, U256, I8, I16, I32, I64, I256)"
  self.description = summary

  self.urls    = ['https://github.com/s6ruby/safemath']

  self.author  = 'Gerald Bauer'
  self.email   = 'wwwmake@googlegroups.com'

  # switch extension to .markdown for gihub formatting
  self.readme_file  = 'README.md'
  self.history_file = 'CHANGELOG.md'

  self.extra_deps = [
  ]

  self.licenses = ['Public Domain']

  self.spec_extras = {
    required_ruby_version: '>= 2.2.2'
  }

end
