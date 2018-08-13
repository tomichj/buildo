lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'buildo/version'

Gem::Specification.new do |spec|
  spec.name          = 'buildo'
  spec.version       = Buildo::VERSION
  spec.authors       = ['Justin Tomich']
  spec.email         = ['tomichj@gmail.com']

  spec.summary       = 'A small collection of generators to jump-start building a Rails application'
  spec.description   = <<~END_OF_LINE
    A small collection of generators to jump-start building a Rails application. 
    Set up oath authentication, some user services, and scaffolding.
  END_OF_LINE
  spec.homepage      = 'http://github.com/tomichj/buildo'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.require_paths = ['lib']
  spec.extra_rdoc_files = %w[README.md LICENSE.txt]

  spec.add_dependency 'rails', '~> 5'
  spec.add_development_dependency 'rspec', '~> 3.2'
end
