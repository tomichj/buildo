require 'rails/generators'
require 'rails/generators/rails/app/app_generator'

module Buildo
  class AppGenerator < Rails::Generators::AppGenerator
    hide!

    def finish_template
      invoke :setup_development_environment
      invoke :setup_production_environment
      invoke :configure_app
      invoke :setup_database
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
    end

    def setup_production_environment
      say 'Setting up the production environment'
      build :enable_rack_canonical_host
      build :enable_rack_deflater
    end

    def configure_app
      say 'Configuring app'
      build :customize_gemfile
      build :setup_secret_token
      build :configure_action_mailer
      build :configure_time_formats
      build :setup_default_rake_task
      build :replace_default_puma_configuration
      build :set_up_forego
      build :setup_rack_mini_profiler
    end

    def setup_database
      say 'Configuring database'
      build :use_postgres_config_template
      build :create_database
    end










    def customize_gemfile
      build :replace_gemfile, options[:path]
      bundle_command 'install'
    end

    protected

    def get_builder_class
      Buildo::AppBuilder
    end

  end
end