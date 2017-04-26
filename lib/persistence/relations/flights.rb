module Persistence
  module Relations
    class Flights < ROM::Relation[:sql]
      schema(:flights) do
        attribute :flight_id, Types::Serial
        attribute :flight_no, Types::Strict::String

        attribute :scheduled_departure, Types::Strict::Time
        attribute :scheduled_arrival,   Types::Strict::Time

        attribute :departure_airport,
                  Types::ForeignKey(:airports, Types::Strict::String)

        attribute :arrival_airport,
                  Types::ForeignKey(:airports, Types::Strict::String)

        attribute :aircraft_code,
                  Types::ForeignKey(:aircrafts, Types::Strict::String)

        attribute :status, Types::Strict::String

        attribute :actual_departure, Types::Strict::Time.optional
        attribute :actual_arrival,   Types::Strict::Time.optional

        primary_key :flight_id

        associations do
          belongs_to :airports, as: :departure_airport,
                                foreign_key: :departure_airport
          belongs_to :airports, as: :arrival_airport,
                                foreign_key: :arrival_airport
          belongs_to :aircraft, foreign_key: :aircraft_code

          has_many :ticket_flights
          has_many :tickets, through: :ticket_flights
        end
      end
    end
  end
end
