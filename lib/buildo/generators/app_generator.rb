require 'rails/generators'
require 'rails/generators/rails/app/app_generator'

module Buildo
  class AppGenerator < Rails::Generators::AppGenerator
    hide!

    class_option :heroku, type: :boolean, aliases: '-H', default: false,
                          desc: 'Create staging and production Heroku apps'

    class_option :heroku_flags, type: :string, default: '',
                                desc: 'Set extra Heroku flags'

    class_option :github, type: :string, default: nil,
                          desc: 'Create Github repository and add remote origin pointed to repo'

    class_option :skip_test, type: :boolean, default: true,
                             desc: 'Skip Test Unit'

    class_option :skip_users, type: :boolean, default: true,
                              desc: 'Skip user services (authentication, user naming & time zones) and scaffolding'

    class_option :skip_segment, type: :boolean, default: true,
                                desc: 'Skip segment analytics support'

    class_option :skip_turbolinks, type: :boolean, default: false,
                                   desc: 'Skip turbolinks gem'

    def finish_template
      invoke :setup_development_environment
      invoke :setup_production_environment
      invoke :configure_app
      invoke :setup_database
      invoke :generate_defaults
      invoke :create_local_heroku_setup
      invoke :create_heroku_apps
      invoke :generate_production_defaults
      invoke :create_github_repo
      super
    end

    def setup_development_environment
      say 'Setting up the development environment'
      build :configure_local_mail
      build :raise_on_missing_assets_in_test
      build :raise_on_delivery_errors
      build :set_test_delivery_method
      build :raise_on_unpermitted_parameters
      build :provide_setup_script
      build :configure_generators
      build :configure_i18n_for_missing_translations
      build :configure_quiet_assets

      say 'Copying env file'
      build :set_up_env

      say 'Springifying binstubs'
      build :setup_spring
    end

    def setup_production_environment
      say 'Setting up the production environment'
      build :enable_rack_canonical_host
      build :enable_rack_deflater
    end

    def configure_app
      say 'Configuring app'
      build :setup_secret_token

      build :replace_gemfile, options[:path]
      bundle_command 'install'

      build :configure_action_mailer
      build :configure_time_formats
      build :setup_default_rake_task
      build :replace_default_puma_configuration
      build :set_up_forego
      build :setup_rack_mini_profiler
      build :copy_miscellaneous_files
      build :customize_error_pages
    end

    def setup_database
      say 'Configuring database'
      build :use_postgres_config_template
      build :create_database
    end

    def generate_defaults
      say 'Generating Defaults'
      run 'spring stop'
      generate 'buildo:stylesheet_base'
      generate 'buildo:static'

      unless options[:api]
        generate 'buildo:forms'
      end

      unless options[:skip_users]
        generate 'buildo:users_services'
      end

      unless options[:skip_segment]
        generate 'buildo:segment'
      end

      generate 'buildo:jobs'
      generate 'buildo:rspec'
      generate 'buildo:factories'
      generate 'buildo:js_driver'
      generate 'buildo:views'
      generate 'buildo:db_optimizations'
    end

    def generate_production_defaults
      say 'Generating Productions Defaults'
      generate 'buildo:production:force_tls'
      generate 'buildo:production:email'
      generate 'buildo:production:timeout'
    end

    def create_local_heroku_setup
      say 'Creating local Heroku setup'
      build :create_review_apps_setup_script
      build :create_deploy_script
      build :create_heroku_application_manifest_file
    end

    def create_heroku_apps
      if options[:heroku]
        say 'Creating Heroku apps'
        generate 'buildo:heroku', options[:heroku_flags]
      end
    end

    def create_github_repo
      if !options[:skip_git] && options[:github]
        say 'Creating Github repo'
        build :create_github_repo, options[:github]
      end
    end

    protected

    def get_builder_class
      Buildo::AppBuilder
    end
  end
end
