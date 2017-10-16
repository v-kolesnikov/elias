require 'elias/repository'

module Api
  module Persistence
    module Repositories
      class Airports < Elias::Repository[:airports]
        def listing
          airports.map_to(Api::Entities::Airport).to_a
        end

        def retrieve(airport_code)
          airports.by_pk(airport_code).map_to(Api::Entities::Airport).one!
        end
      end
    end
  end
end
