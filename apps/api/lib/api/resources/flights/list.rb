require 'api/import'

module Api
  module Resources
    module Flights
      class List
        include Api::Import[:'persistence.repositories.flights']

        def call(_params = {})
          flights.listing.map(&:to_h)
        end
      end
    end
  end
end
