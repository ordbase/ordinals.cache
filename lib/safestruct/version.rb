# encoding: utf-8


###
# note: do not "pollute" Safe namespace / module
#  use its own module
#
#  note: SafeStruct is already taken :-), thus, use SaferStruct


module SaferStruct

  MAJOR = 1
  MINOR = 2
  PATCH = 1
  VERSION = [MAJOR,MINOR,PATCH].join('.')

  def self.version
    VERSION
  end

  def self.banner
    "safestruct/#{VERSION} on Ruby #{RUBY_VERSION} (#{RUBY_RELEASE_DATE}) [#{RUBY_PLATFORM}]"
  end

  def self.root
    "#{File.expand_path( File.dirname(File.dirname(File.dirname(__FILE__))) )}"
  end

end # module SaferStruct
