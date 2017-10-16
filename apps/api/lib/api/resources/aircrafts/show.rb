require 'api/import'

module Api
  module Resources
    module Aircrafts
      class Show
        include Api::Import[:'persistence.repositories.aircrafts']

        def call(id, _params = {})
          aircrafts.retrieve(id).to_h
        end
      end
    end
  end
end
