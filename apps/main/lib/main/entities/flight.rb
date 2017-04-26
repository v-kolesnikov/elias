require "types"

module Main
  module Entities
    class Flight < Dry::Struct
      attribute :flight_id, Types::Strict::Int
      attribute :flight_no, Types::Strict::String
      attribute :scheduled_departure, Types::Strict::Time
      attribute :scheduled_arrival, Types::Strict::Time
      attribute :departure_airport, Types::Strict::String
      attribute :arrival_airport, Types::Strict::String
      attribute :aircraft_code, Types::Strict::String
      attribute :status, Types::FlightStatus
      attribute :actual_departure, Types::Strict::Time.optional
      attribute :actual_arrival, Types::Strict::Time.optional
    end
  end
end
