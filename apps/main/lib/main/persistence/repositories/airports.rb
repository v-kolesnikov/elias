require 'elias/repository'

module Main
  module Persistence
    module Repositories
      class Airports < Elias::Repository[:airports]
        def listing
          airports.map_to Main::Entities::Airport
        end
      end
    end
  end
end
