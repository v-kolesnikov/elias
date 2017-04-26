require "dry/web/umbrella"
require_relative "settings"

module Elias
  class Container < Dry::Web::Umbrella
    configure do
      config.name = :core
      config.settings_loader = Elias::Settings
      config.listeners = true
    end

    load_paths! "lib", "system"

    def self.settings
      config.settings
    end
  end
end
