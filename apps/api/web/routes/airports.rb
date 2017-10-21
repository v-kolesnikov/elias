module Api
  class Application < Dry::Web::Roda::Application
    route 'airports' do |r|
      r.is do
        r.get to: 'resources.airports.list',
              call_with: [r.params]
      end

      r.on(:airport_code) do |airport_code|
        r.get to: 'resources.airports.show',
              call_with: [airport_code, r.params]
      end
    end
  end
end
