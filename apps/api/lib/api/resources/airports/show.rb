require 'api/import'

module Api
  module Resources
    module Airports
      class Show
        include Api::Import[:'persistence.repositories.airports']

        def call(id, _params = {})
          airports.retrieve(id).to_h
        end
      end
    end
  end
end
