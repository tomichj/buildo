require 'rails/generators'

module Buildo
  class StaticGenerator < Rails::Generators::Base
    include Buildo::Helpers

    def add_high_voltage
      gem 'high_voltage'
      Bundler.with_clean_env { run 'bundle install' }
    end

    def add_view_directory
      empty_directory_with_keep_file 'app/views/pages'
    end
  end
end
