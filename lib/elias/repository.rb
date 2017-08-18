# auto_register: false

require 'rom-repository'
require 'elias/container'
require 'elias/import'

Elias::Container.start :rom

module Elias
  class Repository < ROM::Repository::Root
    include Elias::Import.args['persistence.rom']
  end
end
