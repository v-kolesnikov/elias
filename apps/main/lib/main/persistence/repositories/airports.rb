require 'elias/repository'

module Main
  module Persistence
    module Repositories
      class Airports < Elias::Repository[:airports]
        relations :airports, :flights

        def listing
          airports.as Main::Entities::Airport
        end
      end
    end
  end
end
