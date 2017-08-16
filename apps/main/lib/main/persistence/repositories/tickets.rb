require 'elias/repository'

module Main
  module Persistence
    module Repositories
      class Tickets < Elias::Repository[:tickets]
        def listing
          tickets.map_to Main::Entities::Ticket
        end
      end
    end
  end
end
