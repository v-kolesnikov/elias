require 'db_helper'

RSpec.describe Persistence::Relations::Tickets do
  let(:tickets) do
    rom.relations[:tickets]
  end

  it '#most_disciplined_passengers' do
    query = tickets.most_disciplined_passengers

    expected = <<~SQL.split("\n").map(&:strip).join(' ')
        SELECT "tickets"."passenger_name",
               "tickets"."ticket_no"
          FROM "tickets"
               INNER JOIN "boarding_passes"
                       ON ("boarding_passes"."ticket_no" = "tickets"."ticket_no")
      GROUP BY "tickets"."passenger_name",
               "tickets"."ticket_no"
        HAVING ((MAX("boarding_passes"."boarding_no") = 1)
           AND (COUNT('*') > 1))
    SQL

    expect(query.dataset.sql).to eq(expected)
  end
end
