module Elias
  class Application < Roda
    route do |r|
      r.run Main::Application.freeze.app
    end
  end
end
