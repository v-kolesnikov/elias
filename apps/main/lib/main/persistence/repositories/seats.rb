require 'elias/repository'

module Main
  module Persistence
    module Repositories
      class Seats < Elias::Repository[:seats]
        def listing
          seats.map_to Main::Entities::Seat
        end
      end
    end
  end
end
