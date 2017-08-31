require 'elias/repository'

module Api
  module Persistence
    module Repositories
      class BoardingPasses < Elias::Repository[:boarding_passes]
        def listing
          boarding_passes.map_to(Api::Entities::BoardingPass).to_a
        end
      end
    end
  end
end
