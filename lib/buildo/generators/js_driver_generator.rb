require 'rails/generators'

module Buildo
  class JsDriverGenerator < Rails::Generators::Base
    source_root File.expand_path(
      File.join('..', '..', '..', 'templates'),
      File.dirname(__FILE__),
    )

    def add_gems
      gem 'capybara-selenium', group: :test
      gem 'chromedriver-helper', group: :test
      Bundler.with_clean_env { run 'bundle install' }
    end

    def configure_chromedriver
      copy_file 'js_driver/chromedriver.rb', 'spec/support/chromedriver.rb'
    end
  end
end
