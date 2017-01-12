require "elias/repository"

module Main
  module Persistence
    module Repositories
      class Seats < Elias::Repository[:seats]
        relations :seats

        def listing
          seats.as Main::Entities::Seat
        end
      end
    end
  end
end
