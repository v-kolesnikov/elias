require 'dry/web/settings'
require 'types'

module Elias
  class Settings < Dry::Web::Settings
    setting :database_url,    Types::Strict::String.constrained(filled: true)
    setting :database_schema, Types::Strict::String.constrained(filled: true)
    setting :session_secret,  Types::Strict::String.constrained(filled: true)
  end
end
