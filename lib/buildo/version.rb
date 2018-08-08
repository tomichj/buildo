module Buildo
  VERSION = '0.1.2'.freeze
  RAILS_VERSION = '~> 5.2.0'.freeze
  RUBY_VERSION = IO.read("#{File.dirname(__FILE__)}/../../.ruby-version").strip.freeze
end
