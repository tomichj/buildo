require 'rails/generators'

module Buildo
  class AllGenerator < Rails::Generators::Base
    def all
      generate 'buildo:app_base'
      generate 'buildo:scaffolding'
      generate 'buildo:auth'
      generate 'buildo:users_services'
    end
  end
end
