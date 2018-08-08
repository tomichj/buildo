require 'rails/generators'

module Buildo
  class ViewsGenerator < Rails::Generators::Base
    source_root File.expand_path(
      File.join('..', '..', '..', 'templates'),
      File.dirname(__FILE__),
    )

    def create_partials_directory
      empty_directory 'app/views/application'
    end

    def create_shared_flashes
      copy_file 'views/_flashes.html.erb', 'app/views/application/_flashes.html.erb'
      copy_file 'views/flashes_helper.rb', 'app/helpers/flashes_helper.rb'
    end

    def create_shared_javascripts
      copy_file 'views/_javascript.html.erb', 'app/views/application/_javascript.html.erb'
    end

    def create_shared_css_overrides
      copy_file 'views/_css_overrides.html.erb', 'app/views/application/_css_overrides.html.erb'
    end

    def create_application_layout
      template 'views/buildo_layout.html.erb.erb', 'app/views/layouts/application.html.erb', force: true
    end
  end
end
