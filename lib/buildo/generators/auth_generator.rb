require 'rails/generators'

module Buildo
  class AuthenticationGenerator < Rails::Generators::Base
    def add_gems
      gem 'oath'
      gem 'oath-lockdown', github: 'tomichj/oath-lockdown'
      Bundler.with_clean_env { run 'bundle install' }
    end

    def install_oath_lockdown
      generate 'oath:lockdown:install'
    end
  end
end
