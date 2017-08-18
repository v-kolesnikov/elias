require 'elias/repository'

module Api
  module Persistence
    module Repositories
      class Tickets < Elias::Repository[:tickets]
        def listing
          tickets.map_to Api::Entities::Ticket
        end
      end
    end
  end
end
