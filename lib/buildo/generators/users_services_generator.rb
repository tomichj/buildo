require 'rails/generators'

module Buildo
  class UsersServicesGenerator < Rails::Generators::Base
    def add_gems
      gem 'user_naming'
      gem 'user_time_zones'
      Bundler.with_clean_env { run 'bundle install' }
    end

    def install_user_naming
      generate 'user_naming:install'
    end

    def install_user_time_zones
      generate 'user_time_zones:install -j'
    end

  end
end

