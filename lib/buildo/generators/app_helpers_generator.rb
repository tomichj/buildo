require 'rails/generators'

module Buildo
  class AppHelpersGenerator < Rails::Generators::Base
    def add_gems
      gem 'operate'
      gem 'slim-rails'
      gem 'aasm'
      gem 'reform'
      gem 'reform-rails'
      gem 'local_time'
      Bundler.with_clean_env { run 'bundle install' }
    end

    def install_local_time_javascript
      append_to_file 'app/assets/javascripts/application.js' do
        "//= require local-time\n"
      end
    end
  end
end
