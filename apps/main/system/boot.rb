require_relative "main/container"

Main::Container.finalize!

require "main/application"
require "main/transactions"

Main::Container.require "transactions/**/*.rb"
