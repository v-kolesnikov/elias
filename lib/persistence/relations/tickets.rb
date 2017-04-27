module Persistence
  module Relations
    class Tickets < ROM::Relation[:sql]
      schema(:tickets) do
        attribute :ticket_no, Types::Strict::String
        attribute :book_ref,  Types::Strict::String
        attribute :passenger_id, Types::Strict::String
        attribute :passenger_name, Types::Strict::String
        attribute :contact_data, Types::PG::JSONB

        primary_key :ticket_no

        associations do
          belongs_to :booking, foreign_key: :book_ref

          has_many :boarding_passes, foreign_key: :ticket_no
          has_many :ticket_flights,  foreign_key: :ticket_no

          has_many :flights, through: :ticket_flights
        end
      end
    end
  end
end
