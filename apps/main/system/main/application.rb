require "rack/csrf"
require "dry/web/roda/application"
require_relative "container"
require "roda_plugins"

module Main
  class Application < Dry::Web::Roda::Application
    configure do |config|
      config.routes = "web/routes".freeze
      config.container = Container
    end

    opts[:root] = Pathname(__FILE__).join("../..").realpath.dirname

    use Rack::Session::Cookie,
        key: "main.session",
        secret: Elias::Container.settings.session_secret

    use Rack::Csrf, raise: true

    plugin :flash

    plugin :view
    plugin :page

    def name
      :main
    end

    route do |r|
      r.multi_route
    end

    load_routes!
  end
end
