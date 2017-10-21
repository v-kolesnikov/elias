module Api
  class Application < Dry::Web::Roda::Application
    route 'flights' do |r|
      r.is do
        r.get to: 'resources.flights.list',
              call_with: [r.params]
      end

      r.on(:flight_no) do |flight_no|
        r.get to: 'resources.flights.show',
              call_with: [flight_no, r.params]
      end
    end
  end
end
