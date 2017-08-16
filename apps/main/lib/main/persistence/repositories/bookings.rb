require 'elias/repository'

module Main
  module Persistence
    module Repositories
      class Bookings < Elias::Repository[:bookings]
        relations :bookings, :tickets

        def listing
          bookings.map_to Main::Entities::Booking
        end
      end
    end
  end
end
