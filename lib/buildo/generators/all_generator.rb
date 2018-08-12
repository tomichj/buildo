require 'rails/generators'

module Buildo
  class AllGenerator < Rails::Generators::Base
    def all
      generate 'buildo:app_helpers'
      generate 'buildo:auth_generator'
      generate 'buildo:scaffolding_generator'
      generate 'buildo:users_services_generator'
    end
  end
end
