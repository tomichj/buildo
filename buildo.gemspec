lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'buildo/version'

Gem::Specification.new do |spec|
  spec.name          = 'buildo'
  spec.version       = Buildo::VERSION
  spec.authors       = ['Justin Tomich']
  spec.email         = ['tomichj@gmail.com']

  spec.summary       = 'Generate a rails app with all the fixins'
  spec.description   = 'Generate a rails app with all the fixins'
  spec.homepage      = 'http://github.com/tomichh/buildo'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.executables   = ['buildo']
  spec.require_paths = ['lib']
  spec.extra_rdoc_files = %w[README.md LICENSE.txt]

  spec.required_ruby_version = ">= #{Buildo::RUBY_VERSION}"

  spec.add_dependency 'rails', Buildo::RAILS_VERSION
  spec.add_development_dependency 'rspec', '~> 3.2'
end
