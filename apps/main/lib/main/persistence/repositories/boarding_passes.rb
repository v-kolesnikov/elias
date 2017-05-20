require 'elias/repository'

module Main
  module Persistence
    module Repositories
      class BoardingPasses < Elias::Repository[:boarding_passes]
        relations :boarding_passes

        def listing
          boarding_passes.as Main::Entities::BoardingPass
        end
      end
    end
  end
end
