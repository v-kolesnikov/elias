require "elias/repository"

module Main
  module Persistence
    module Repositories
      class Flights < Elias::Repository[:flights]
        relations :flights

        def listing
          flights.as Main::Entities::Flight
        end
      end
    end
  end
end
