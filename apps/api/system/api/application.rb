require 'dry/web/roda/application'
require_relative 'container'

module Api
  class Application < Dry::Web::Roda::Application
    configure do |config|
      config.container = Api::Container
      config.routes = 'web/routes'.freeze
    end

    opts[:root] = Pathname(__FILE__).join('../..').realpath.dirname

    use Rack::Session::Cookie,
        key: 'api.session',
        secret: self['core.settings'].session_secret

    plugin :csrf, raise: false
    plugin :json

    route do |r|
      r.multi_route

      r.root do
        'Welcome to Elias API'
      end
    end

    error do |e|
      self.class[:rack_monitor].instrument(:error, exception: e)
      raise e
    end

    load_routes!
  end
end
