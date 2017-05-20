require 'types'

module Main
  module Entities
    class Seat < Dry::Struct
      attribute :aircraft_code, Types::Strict::String
      attribute :seat_no, Types::Strict::String
      attribute :fare_conditions, Types::Strict::String
    end
  end
end
