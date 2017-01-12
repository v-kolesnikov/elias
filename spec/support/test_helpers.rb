module TestHelpers
  module_function

  def app
    Elias::Application.app
  end

  def rom
    Elias::Container["persistence.rom"]
  end

  def db_connection
    rom.gateways[:default].connection
  end
end
