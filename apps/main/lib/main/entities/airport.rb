require 'types'

module Main
  module Entities
    class Airport < Dry::Struct
      attribute :airport_code, Types::AirportCode
      attribute :airport_name, Types::Strict::String
      attribute :city, Types::Strict::String
      attribute :longitude, Types::Strict::Float
      attribute :latitude, Types::Strict::Float
      attribute :timezone, Types::Strict::String
    end
  end
end
