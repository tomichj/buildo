require 'rails/generators'

module Buildo
  class AllGenerator < Rails::Generators::Base
    def all
      generate 'buildo:app_helpers'
      generate 'buildo:auth'
      generate 'buildo:scaffolding'
      generate 'buildo:users_services'
    end
  end
end
