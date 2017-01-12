module Persistence
  module Relations
    class Airports < ROM::Relation[:sql]
      schema(:airports) do
        attribute :airport_code, Types::Strict::String
        attribute :airport_name, Types::Strict::String
        attribute :city,         Types::Strict::String
        attribute :longitude,    Types::Strict::Float
        attribute :latitude,     Types::Strict::Float
        attribute :timezone,     Types::Strict::String

        primary_key :airport_code

        associations do
          has_many :flights, as: :departing_flights,
                             foreign_key: :departure_airport
          has_many :flights, as: :arriving_flights,
                             foreign_key: :arrival_airport
        end
      end

      def by_city(city)
        where(city: city)
      end

      def by_code(code)
        where(airport_code: code)
      end

      def by_name(name)
        where(airport_name: name)
      end
    end
  end
end
