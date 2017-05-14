module Persistence
  module Relations
    class TicketFlights < ROM::Relation[:sql]
      schema(:ticket_flights) do
        attribute :ticket_no, Types::Strict::String
        attribute :flight_id, Types::Strict::Int
        attribute :fare_conditions, Types::Strict::String
        attribute :amount, Types::Coercible::Float

        primary_key :ticket_no, :flight_id

        associations do
          belongs_to :flight
          belongs_to :ticket, foreign_key: :ticket_no
        end
      end
    end
  end
end
