require 'elias/repository'

module Api
  module Persistence
    module Repositories
      class Bookings < Elias::Repository[:bookings]
        def listing
          bookings.map_to Api::Entities::Booking
        end
      end
    end
  end
end
