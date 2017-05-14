require 'db_helper'

RSpec.describe Persistence::Relations::Bookings do
  let(:bookings) do
    rom.relations[:bookings]
  end

  it 'passenger_by_seat_no' do
    query = bookings.passenger_by_seat_no('SVO', 'OVB', '1A', 2)

    expected = <<~SQL.split("\n").map(&:strip).join(' ')
      SELECT "tickets"."passenger_name",
             "bookings"."book_date"
        FROM "bookings"
              INNER JOIN "tickets"
                      ON ("tickets"."book_ref" = "bookings"."book_ref")
              INNER JOIN "boarding_passes"
                      ON ("boarding_passes"."ticket_no" = "tickets"."ticket_no")
              INNER JOIN "flights"
                      ON ("flights"."flight_id" = "boarding_passes"."flight_id")
       WHERE (("flights"."departure_airport" = 'SVO')
         AND ("flights"."arrival_airport" = 'OVB')
         AND ("boarding_passes"."seat_no" = '1A')
         AND (CAST("flights"."scheduled_departure" AS date) =
              CAST((BOOKINGS_NOW() - CAST('2 days' AS interval)) AS date)))
    SQL

    expect(query.dataset.sql).to eq expected
  end
end
