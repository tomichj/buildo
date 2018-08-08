require 'rails/generators'

module Buildo
  class UsersServicesGenerator < Rails::Generators::Base
    source_root File.expand_path(
      File.join('..', '..', '..', 'templates'),
      File.dirname(__FILE__),
      )

    def add_gems
      gem 'oath'
      gem 'oath-generators', group: %i(development test)
      gem 'oath-lockdown', github: 'tomichj/oath-lockdown'
      gem 'user_naming'
      gem 'user_time_zones'
      Bundler.with_clean_env { run 'bundle install' }
    end

    def generate_oath_scaffolds
      generate 'oath:scaffold'
    end

    def install_oath_lockdown
      generate 'oath:lockdown:install'
    end

    def replace_sessions_controller
      copy_file(
        'users_services/sessions_controller.rb',
        'app/controllers/sessions_controller.rb',
        force: true,
        )
    end

    def install_user_naming
      generate 'user_naming:install'
    end

    def install_user_time_zones
      generate 'user_time_zones:install -j'
    end
  end
end
