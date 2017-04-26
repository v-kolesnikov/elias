require "slim"
require "dry-view"
require "main/container"

module Main
  class ViewController < Dry::View::Controller
    configure do |config|
      config.paths = [Container.root.join("web/templates")]
      config.context = Container["view_context"]
      config.layout = "application"
    end
  end
end
