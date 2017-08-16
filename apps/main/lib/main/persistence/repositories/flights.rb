require 'elias/repository'

module Main
  module Persistence
    module Repositories
      class Flights < Elias::Repository[:flights]
        def listing
          flights.map_to Main::Entities::Flight
        end
      end
    end
  end
end
