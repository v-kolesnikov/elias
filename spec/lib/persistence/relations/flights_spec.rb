require 'db_helper'

RSpec.describe Persistence::Relations::Flights do
  let(:flights) do
    rom.relations[:flights]
  end

  it '#top_greatest_delays' do
    query = flights.top_greatest_delays(10)

    expected = <<~SQL.split("\n").map(&:strip).join(' ')
        SELECT "flights"."flight_no",
               "flights"."scheduled_departure",
               "flights"."actual_departure",
               ("flights"."actual_departure" - "flights"."scheduled_departure")
               AS "delay"
          FROM "flights"
         WHERE ("flights"."actual_departure" IS NOT NULL)
      ORDER BY ("flights"."actual_departure" - "flights"."scheduled_departure")
               DESC
         LIMIT 10
    SQL

    expect(query.dataset.sql).to eq(expected)
  end
end
