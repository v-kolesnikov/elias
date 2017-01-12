require_relative "main/container"

Main::Container.finalize! do |container|
end

require "main/application"
require "main/view"
require "main/transactions"

Main::Container.require "transactions/**/*.rb"
