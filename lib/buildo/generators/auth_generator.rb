require 'rails/generators'

module Buildo
  class AuthGenerator < Rails::Generators::Base
    def add_gems
      say 'Installing authentication gems'
      gem 'oath'
      gem 'oath-lockdown', github: 'tomichj/oath-lockdown'
      Bundler.with_clean_env { run 'bundle install' }
    end

    def install_oath_lockdown
      generate 'oath:lockdown:install'
    end

    def outro
      say 'Be sure to `rails db:migrate` after this generator runs.'
    end
  end
end
