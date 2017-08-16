require 'elias/repository'

module Main
  module Persistence
    module Repositories
      class BoardingPasses < Elias::Repository[:boarding_passes]
        relations :boarding_passes

        def listing
          boarding_passes.map_to Main::Entities::BoardingPass
        end
      end
    end
  end
end
