require 'dry-transaction'
require 'elias/transactions'
require 'main/container'
require 'main/import'

module Main
  class Transactions < Elias::Transactions
    configure do |config|
      config.container = Main::Container
    end
  end
end
