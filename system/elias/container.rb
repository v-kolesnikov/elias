require 'dry/web/container'

module Elias
  class Container < Dry::Web::Container
    configure do
      config.name = :elias
      config.listeners = true
      config.default_namespace = 'elias'
      config.auto_register = %w[lib/elias]
    end

    load_paths! 'lib'
  end
end
