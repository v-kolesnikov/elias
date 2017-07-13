module Test
  module DatabaseHelpers
    module_function

    def rom
      Elias::Container['persistence.rom']
    end

    def db
      Elias::Container['persistence.db']
    end
  end
end
