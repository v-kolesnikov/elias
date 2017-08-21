module Api
  class Application < Dry::Web::Roda::Application
    route 'aircrafts' do |r|
      repo = Container['persistence.repositories.aircrafts']

      r.is do
        r.get do
          { data: repo.listing.map(&:to_h) }
        end
      end

      r.on(:aircraft_code) do |aircraft_code|
        r.get do
          repo.by_code(aircraft_code).to_h
        end
      end
    end
  end
end
