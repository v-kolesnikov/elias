require 'elias/repository'

module Api
  module Persistence
    module Repositories
      class Airports < Elias::Repository[:airports]
        def listing
          airports.map_to Api::Entities::Airport
        end

        def by_code(airport_code)
          airports.by_pk(airport_code).one!
        end
      end
    end
  end
end
