require "dry/web/settings"
require "dry-types"

module Elias
  class Settings < Dry::Web::Settings
    module Types
      include Dry::Types.module

      module Required
        String = Types::Strict::String.constrained(min_size: 1)
      end
    end

    setting :database_url, Types::Required::String
    setting :database_schema, Types::Required::String.default("public")
    setting :session_secret, Types::Required::String
  end
end
