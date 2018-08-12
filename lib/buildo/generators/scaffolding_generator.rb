require 'rails/generators'

module Buildo
  class ScaffoldingGenerator < Rails::Generators::Base
    source_root File.expand_path(
      File.join('..', '..', '..', 'templates'),
      File.dirname(__FILE__)
    )

    def add_gems
      gem 'oath-generators', group: %i(development test)
      Bundler.with_clean_env { run 'bundle install' }
    end

    def generate_oath_scaffolds
      say 'Generating user model and authorization scaffolding.'
      generate 'oath:scaffold'
    end

    def replace_sessions_controller
      copy_file(
        'sessions_controller.rb',
        'app/controllers/sessions_controller.rb',
        force: true
      )
    end

    def replace_sessions_new_view
      copy_file(
        'sessions_new.html.erb',
        'app/views/sessions/new.html.erb',
        force: true
      )
    end

    def add_sign_in_sign_out_routes
      say 'Adding routes for sign_in, sign_out, and sign_up'
      route "get '/sign_in', to: 'sessions#new', as: 'sign_in'"
      route "get '/sign_out', to: 'sessions#destroy', as: 'sign_out'"
      route "get '/sign_up', to: 'users#new', as: 'sign_up'"
    end

    def add_partial
      return unless File.exist?('app/views/application')

      say 'Added partial with sign in, sign out, and sign up links.'
      say 'You can add it to your layout.'
      copy_file '_sign_in_out.html.erb',
                'app/views/application/_sign_in_out.html.erb'
    end

    def outro
      say 'Be sure to `rails db:migrate` after this generator runs.'
    end
  end
end
