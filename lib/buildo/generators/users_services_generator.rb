require 'rails/generators'

module Buildo
  class UsersServicesGenerator < Rails::Generators::Base
    def add_gems
      gem 'user_naming'
      gem 'user_time_zones'
      gem 'local_time'
      Bundler.with_clean_env { run 'bundle install' }
    end

    def install_user_naming
      generate 'user_naming:install'
    end

    def install_user_time_zones
      generate 'user_time_zones:install -j'
    end

    def install_local_time_javascript
      return unless File.exist?(js_assets)
      append_to_file js_assets, '//= require local-time'
    end

    private

    def js_assets
      'app/assets/javascripts/application.js'
    end

    def js_partial
      'app/views/application/_javascript.html.erb'
    end
  end
end

