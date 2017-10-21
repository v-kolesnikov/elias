require 'api/import'

module Api
  module Resources
    module Aircrafts
      class List
        include Api::Import[:'persistence.repositories.aircrafts']

        def call(_params = {})
          { data: aircrafts.listing.map(&:to_h) }
        end
      end
    end
  end
end
