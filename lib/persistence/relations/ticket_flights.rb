module Persistence
  module Relations
    class TicketFlights < ROM::Relation[:sql]
      schema(:ticket_flights, infer: true) do
        associations do
          belongs_to :flight
          belongs_to :ticket, foreign_key: :ticket_no
        end
      end
    end
  end
end
