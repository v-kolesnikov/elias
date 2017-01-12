module Persistence
  module Relations
    class Seats < ROM::Relation[:sql]
      schema(:seats, infer: true) do
        associations do
          belongs_to :aircraft, foreign_key: :aircraft_code
        end
      end
    end
  end
end
