require 'dry-struct'
require 'dry-types'

module Types
  include Dry::Types.module

  AirportCode  = Types::Strict::String.constrained(format: /[A-Z]{3}/)

  FlightStatus = Types::Strict::String.enum(
    'Scheduled',
    'On Time',
    'Delayed',
    'Departed',
    'Arrived',
    'Cancelled'
  )
end
