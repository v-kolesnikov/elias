require 'pathname'
require 'dry/web/container'

module Main
  class Container < Dry::Web::Container
    require root.join('system/elias/container')
    import core: Elias::Container

    register :rack_monitor, Elias::Container[:rack_monitor]

    configure do |config|
      config.root = Pathname(__FILE__).join('../..').realpath.dirname.freeze
      config.logger = Elias::Container[:logger]
      config.default_namespace = 'main'
      config.auto_register = %w[lib/main]
    end

    load_paths! 'lib'
  end
end
