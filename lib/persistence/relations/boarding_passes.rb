module Persistence
  module Relations
    class BoardingPasses < ROM::Relation[:sql]
      schema(:boarding_passes, infer: true) do
        associations do
          belongs_to :flight
          belongs_to :ticket, foreign_key: :ticket_no
        end
      end
    end
  end
end
