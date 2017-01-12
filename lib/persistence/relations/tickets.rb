module Persistence
  module Relations
    class Tickets < ROM::Relation[:sql]
      schema(:tickets, infer: true) do
        associations do
          belongs_to :booking, foreign_key: :book_ref
          has_many :ticket_flights, foreign_key: :ticket_no
          has_many :flights, through: :ticket_flights, foreign_key: :ticket_no
        end
      end
    end
  end
end
