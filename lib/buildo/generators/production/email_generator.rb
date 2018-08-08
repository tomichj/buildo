require 'rails/generators'
require_relative '../../helpers'

module Buildo
  module Production
    class EmailGenerator < Rails::Generators::Base
      include Buildo::Helpers

      source_root File.expand_path(
        File.join('..', '..', '..', '..', 'templates'),
        File.dirname(__FILE__),
      )

      def smtp_configuration
        copy_file 'production/smtp.rb', 'config/smtp.rb'

        prepend_file 'config/environments/production.rb',
                     %{require Rails.root.join("config/smtp")\n}
      end

      def use_smtp
        config = <<-RUBY

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = SMTP_SETTINGS
        RUBY

        inject_into_file 'config/environments/production.rb', config,
                         after: 'config.action_mailer.raise_delivery_errors = false'
      end

      def env_vars
        expand_json(
          'app.json',
          env: {
            SMTP_ADDRESS: { required: true },
            SMTP_DOMAIN: { required: true },
            SMTP_PASSWORD: { required: true },
            SMTP_USERNAME: { required: true },
          },
        )
      end
    end
  end
end
