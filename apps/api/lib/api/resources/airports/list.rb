require 'api/import'

module Api
  module Resources
    module Airports
      class List
        include Api::Import[:'persistence.repositories.airports']

        def call(_params = {})
          { data: airports.listing.map(&:to_h) }
        end
      end
    end
  end
end
