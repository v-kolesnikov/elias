module Persistence
  module Relations
    class BoardingPasses < ROM::Relation[:sql]
      schema(:boarding_passes) do
        attribute :ticket_no, Types::Strict::String
        attribute :flight_id, Types::Strict::Int
        attribute :boarding_no, Types::Strict::Int
        attribute :seat_no, Types::Strict::String

        associations do
          belongs_to :flight
          belongs_to :ticket, foreign_key: :ticket_no
        end
      end
    end
  end
end
