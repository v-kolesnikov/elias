require 'api/import'

module Api
  module Resources
    module Flights
      class Show
        include Api::Import[:'persistence.repositories.flights']

        def call(id, _params = {})
          flights.retrieve(id).to_h
        end
      end
    end
  end
end
