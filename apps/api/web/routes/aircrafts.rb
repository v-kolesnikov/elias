module Api
  class Application < Dry::Web::Roda::Application
    route 'aircrafts' do |r|
      r.is do
        r.get to: 'resources.aircrafts.list',
              call_with: [r.params]
      end

      r.on(:aircraft_code) do |aircraft_code|
        r.get to: 'resources.aircrafts.show',
              call_with: [aircraft_code, r.params]
      end
    end
  end
end
