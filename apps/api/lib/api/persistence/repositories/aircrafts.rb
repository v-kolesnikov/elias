require 'elias/repository'

module Api
  module Persistence
    module Repositories
      class Aircrafts < Elias::Repository[:aircrafts]
        def listing
          aircrafts.map_to(Api::Entities::Aircraft).to_a
        end

        def by_code(aircraft_code)
          aircrafts.by_pk(aircraft_code).one!
        end
      end
    end
  end
end
