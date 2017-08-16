require 'elias/repository'

module Main
  module Persistence
    module Repositories
      class Tickets < Elias::Repository[:tickets]
        relations :tickets, :bookings, :ticket_flights, :flights

        def listing
          tickets.map_to Main::Entities::Ticket
        end
      end
    end
  end
end
