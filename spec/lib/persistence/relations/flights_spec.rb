require 'db_helper'

RSpec.describe Persistence::Relations::Flights do
  let(:flights) do
    rom.relations[:flights]
  end

  it 'seats left' do
    query = flights.seats_left('PG0404', 1)

    expected = <<~SQL.split("\n").map(&:strip).join(' ')
      SELECT COUNT('*')
        FROM "flights"
             INNER JOIN "seats"
                     ON ("seats"."aircraft_code" = "flights"."aircraft_code")
       WHERE (("flights"."flight_no" = 'PG0404')
         AND (CAST("flights"."scheduled_departure" AS date) =
              CAST((BOOKINGS_NOW() - CAST('1 days' AS interval)) AS date))
         AND NOT (EXISTS
               (SELECT NULL
                  FROM "boarding_passes"
                 WHERE (("boarding_passes"."flight_id" = "flights"."flight_id")
                   AND ("boarding_passes"."seat_no" = "seats"."seat_no")))))
    SQL

    expect(query.dataset.sql).to eq(expected)
  end
end
