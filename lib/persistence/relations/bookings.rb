module Persistence
  module Relations
    class Bookings < ROM::Relation[:sql]
      schema(:bookings) do
        attribute :book_ref,     Types::Strict::String
        attribute :book_date,    Types::Strict::Time
        attribute :total_amount, Types::Strict::Float

        primary_key :book_ref

        associations do
          has_many :tickets, foreign_key: :book_ref
          has_many :boarding_passes
          has_many :ticket_flights
          has_many :flights
        end
      end

      view(:passenger_by_seat_no) do
        schema do
          new([relations[:tickets][:passenger_name].qualified,
               relations[:bookings][:book_date].qualified])
        end

        relation do |departure_airport, arrival_airport, seat_no, ago|
          bookings
            .order(nil)
            .join(:tickets, book_ref: :book_ref)
            .join(:boarding_passes, ticket_no: :ticket_no)
            .join(:flights, flight_id: :flight_id)
            .where(flights[:departure_airport].qualified => departure_airport)
            .where(flights[:arrival_airport].qualified => arrival_airport)
            .where(boarding_passes[:seat_no].qualified => seat_no)
            .where do
              date::cast(flights[:scheduled_departure], :date).is(
                date::cast(
                  time::bookings_now() - any::cast("#{ago} days", :interval),
                  :date
                )
              )
            end
        end
      end

      use :pagination
      per_page 100
    end
  end
end
