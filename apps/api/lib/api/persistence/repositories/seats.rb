require 'elias/repository'

module Api
  module Persistence
    module Repositories
      class Seats < Elias::Repository[:seats]
        def listing
          seats.map_to Api::Entities::Seat
        end
      end
    end
  end
end
