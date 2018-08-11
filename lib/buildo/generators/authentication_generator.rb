require 'rails/generators'

module Buildo
  class AuthenticationGenerator < Rails::Generators::Base
    source_root File.expand_path(
      File.join('..', '..', '..', 'templates'),
      File.dirname(__FILE__),
      )

    def add_gems
      gem 'oath'
      gem 'oath-generators', group: %i(development test)
      gem 'oath-lockdown', github: 'tomichj/oath-lockdown'
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
        force: true
        )
    end

    def replace_sessions_new_view
      copy_file(
        'users_services/sessions_new.html.erb',
        'app/views/sessions/new.html.erb',
        force: true
      )
    end

    def add_sign_in_sign_out_routes
      routes <<-EOS
  get '/sign_in', to: 'sessions#new', as: 'sign_in'
  get '/sign_out', to: 'sessions#destroy', as: 'sign_out'
  get '/sign_up', to: 'users#new', as: 'sign_up'
EOS
      route routes
    end

    def add_partial
      return unless File.exist?('app/views/application')
      copy_file 'users_services/_sign_in_out.html.erb',
                'app/views/application/_sign_in_out.html.erb'
    end

    def outro
    end

    private

    def view_applications_dir
      'app/views/application'
    end
  end
end
