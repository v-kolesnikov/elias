module Persistence
  module Relations
    class Aircrafts < ROM::Relation[:sql]
      schema(:aircrafts) do
        attribute :aircraft_code, Types::Strict::String
        attribute :model, Types::Strict::String
        attribute :range, Types::Strict::Int

        primary_key :aircraft_code

        associations do
          has_many :flights, foreign_key: :aircraft_code
          has_many :seats, foreign_key: :aircraft_code
        end
      end
    end
  end
end
