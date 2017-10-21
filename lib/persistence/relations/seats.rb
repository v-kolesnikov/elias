module Persistence
  module Relations
    class Seats < ROM::Relation[:sql]
      schema(:seats) do
        attribute :aircraft_code, Types::Strict::String
        attribute :seat_no, Types::Strict::String
        attribute :fare_conditions, Types::Strict::String

        primary_key :aircraft_code, :seat_no

        associations do
          belongs_to :aircraft, foreign_key: :aircraft_code
        end
      end

      use :pagination
      per_page 100
    end
  end
end
