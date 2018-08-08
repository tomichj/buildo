require 'rails/generators'
require_relative '../../helpers'

module Buildo
  module Production
    class ForceTlsGenerator < Rails::Generators::Base
      include Buildo::Helpers

      def config_enforce_ssl
        configure_environment 'production', 'config.force_ssl = true'
      end
    end
  end
end
