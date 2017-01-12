require "types"

module Main
  module Entities
    class BoardingPass < Dry::Struct
      attribute :ticket_no, Types::Strict::String
      attribute :flight_id, Types::Strict::Int
      attribute :boarding_no, Types::Strict::Int
      attribute :seat_no, Types::Strict::String
    end
  end
end
