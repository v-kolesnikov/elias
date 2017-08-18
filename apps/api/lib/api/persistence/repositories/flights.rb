require 'elias/repository'

module Api
  module Persistence
    module Repositories
      class Flights < Elias::Repository[:flights]
        def listing
          flights.map_to Api::Entities::Flight
        end
      end
    end
  end
end
