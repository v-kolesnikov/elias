require 'types'

module Api
  module Entities
    class Booking < Dry::Struct
      attribute :book_ref, Types::Strict::String
      attribute :book_date, Types::Strict::Time
      attribute :total_amount, Types::Coercible::Int
    end
  end
end
