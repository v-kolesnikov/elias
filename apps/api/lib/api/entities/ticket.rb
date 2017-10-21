require 'types'

module Api
  module Entities
    class Ticket < Dry::Struct
      attribute :ticket_no, Types::Strict::String
      attribute :book_ref, Types::Strict::String
      attribute :passenger_id, Types::Strict::String
      attribute :passenger_name, Types::Strict::String
      attribute :contact_data, Types::Coercible::Hash
    end
  end
end
