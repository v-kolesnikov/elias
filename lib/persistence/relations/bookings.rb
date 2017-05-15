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
        end
      end
    end
  end
end
