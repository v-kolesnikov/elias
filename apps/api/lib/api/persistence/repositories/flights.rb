require 'elias/repository'

module Api
  module Persistence
    module Repositories
      class Flights < Elias::Repository[:flights]
        def listing(limit: 20)
          flights.limit(limit).map_to(Api::Entities::Flight).to_a
        end

        def retrieve(id)
          flights.by_pk(id).map_to(Api::Entities::Flight).one!
        end
      end
    end
  end
end
