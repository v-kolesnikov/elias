require 'elias/repository'

module Main
  module Persistence
    module Repositories
      class Aircrafts < Elias::Repository[:aircrafts]
        relations :aircrafts, :flights, :seats

        def listing
          aircrafts.map_to Main::Entities::Aircraft
        end
      end
    end
  end
end
