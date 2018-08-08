require 'forwardable'

module Buildo
  class AppBuilder < Rails::AppBuilder
    include Buildo::Helpers
    extend Forwardable

    def gitignore
      copy_file "buildo_gitignore", ".gitignore"
    end

    def gemfile
      template "Gemfile.erb", "Gemfile"
    end

    def ruby_version
      create_file '.ruby-version', "#{Buildo::RUBY_VERSION}\n"
    end






    ######################################################
    # Development Environment
    def configure_local_mail
      copy_file "email.rb", "config/initializers/email.rb"
    end

    def raise_on_missing_assets_in_test
      configure_environment "test", "config.assets.raise_runtime_errors = true"
    end

    def raise_on_delivery_errors
      replace_in_file 'config/environments/development.rb',
                      'raise_delivery_errors = false', 'raise_delivery_errors = true'
    end

    def set_test_delivery_method
      inject_into_file(
        "config/environments/development.rb",
        "\n  config.action_mailer.delivery_method = :file",
        after: "config.action_mailer.raise_delivery_errors = true",
        )
    end

    def raise_on_unpermitted_parameters
      config = <<-RUBY
    config.action_controller.action_on_unpermitted_parameters = :raise
      RUBY

      inject_into_class "config/application.rb", "Application", config
    end

    def provide_setup_script
      template "bin_setup", "bin/setup", force: true
      run "chmod a+x bin/setup"
    end

    def configure_generators
      config = <<-RUBY

    config.generators do |generate|
      generate.helper false
      generate.javascripts false
      generate.request_specs false
      generate.routing_specs false
      generate.stylesheets false
      generate.test_framework :rspec
      generate.view_specs false
    end

      RUBY

      inject_into_class 'config/application.rb', 'Application', config
    end

    def configure_i18n_for_missing_translations
      raise_on_missing_translations_in("development")
      raise_on_missing_translations_in("test")
    end

    def configure_quiet_assets
      config = <<-RUBY
    config.assets.quiet = true
      RUBY

      inject_into_class "config/application.rb", "Application", config
    end









    ##################################################
    # Production Environment
    def enable_rack_canonical_host
      config = <<-RUBY

  if ENV.fetch("HEROKU_APP_NAME", "").include?("staging-pr-")
    ENV["APPLICATION_HOST"] = ENV["HEROKU_APP_NAME"] + ".herokuapp.com"
  end

  config.middleware.use Rack::CanonicalHost, ENV.fetch("APPLICATION_HOST")
      RUBY

      configure_environment 'production', config
    end

    def enable_rack_deflater
      configure_environment 'production', 'config.middleware.use Rack::Deflater'
    end









    ######################################################
    # Configure app
    def replace_gemfile(path)
      template 'Gemfile.erb', 'Gemfile', force: true do |content|
        if path
          content.gsub(%r{gem .buildo.}) { |s| %{#{s}, path: "#{path}"} }
        else
          content
        end
      end
    end

    def setup_secret_token
      template 'secrets.yml', 'config/secrets.yml', force: true
    end

    def configure_action_mailer
      action_mailer_host 'development', %{"localhost:3000"}
      action_mailer_asset_host 'development', %{"http://localhost:3000"}
      action_mailer_host 'test', %{"www.example.com"}
      action_mailer_asset_host 'test', %{"http://www.example.com"}
      action_mailer_host 'production', %{ENV.fetch("APPLICATION_HOST")}
      action_mailer_asset_host(
        'production',
        %{ENV.fetch("ASSET_HOST", ENV.fetch("APPLICATION_HOST"))},
        )
    end

    def configure_time_formats
      remove_file 'config/locales/en.yml'
      template 'config_locales_en.yml.erb', 'config/locales/en.yml'
    end

    def setup_default_rake_task
      append_file 'Rakefile' do
        <<-EOS
task(:default).clear
task default: [:spec]

if defined? RSpec
  task(:spec).clear
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.verbose = false
  end
end
        EOS
      end
    end

    def replace_default_puma_configuration
      copy_file 'puma.rb', 'config/puma.rb', force: true
    end

    def set_up_forego
      copy_file 'Procfile', 'Procfile'
    end

    def setup_rack_mini_profiler
      copy_file("rack_mini_profiler.rb", "config/initializers/rack_mini_profiler.rb", )
    end









    ##########################################################
    # Setup Database
    def use_postgres_config_template
      template 'postgresql_database.yml.erb', 'config/database.yml', force: true
    end

    def create_database
      bundle_command 'exec rails db:create db:migrate'
    end






    def create_github_repo(repo_name)
      run "hub create #{repo_name}"
    end






    def configure_action_mailer_in_specs
      copy_file 'action_mailer.rb', 'spec/support/action_mailer.rb'
    end




    def set_up_env
      copy_file 'dotfiles/.env', 'env'
    end



    private

    def raise_on_missing_translations_in(environment)
      config = 'config.action_view.raise_on_missing_translations = true'

      uncomment_lines("config/environments/#{environment}.rb", config)
    end

  end
end
