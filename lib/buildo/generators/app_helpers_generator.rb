require 'rails/generators'

module Buildo
  class AppHelpersGenerator < Rails::Generators::Base
    def add_gems
      gem 'operate'
      gem 'slim-rails'
      gem 'aasm'
      gem 'reform'
      gem 'reform-rails'

      Bundler.with_clean_env { run 'bundle install' }
    end
  end
end
