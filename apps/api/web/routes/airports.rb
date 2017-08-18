module Api
  class Application < Dry::Web::Roda::Application
    route 'airports' do |r|
      repo = Container['persistence.repositories.airports']

      r.is do
        r.get do
          { data: repo.listing.map(&:to_h) }
        end
      end

      r.on(':airport_code') do |airport_code|
        r.get do
          repo.by_code(airport_code).to_h
        end
      end
    end
  end
end
