require 'rails/generators'

module Buildo
  class UsersServicesGenerator < Rails::Generators::Base
    def verify
      unless File.exist? 'app/models/user.rb'
        puts 'Exiting: you do not have a User model at app/models/User.rb.'
        exit 1
      end
    end

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

