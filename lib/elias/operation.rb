# auto_register: false

require 'dry/transaction/operation'

module Elias
  class Operation
    include Dry::Transaction::Operation
  end
end
