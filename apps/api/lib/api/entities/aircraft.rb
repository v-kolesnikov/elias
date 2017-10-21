require 'types'

module Api
  module Entities
    class Aircraft < Dry::Struct
      attribute :aircraft_code, Types::Strict::String
      attribute :model, Types::Strict::String
      attribute :range, Types::Strict::Int
    end
  end
end
