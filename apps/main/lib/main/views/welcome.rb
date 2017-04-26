require "main/view_controller"

module Main
  module Views
    class Welcome < Main::ViewController
      configure do |config|
        config.template = "welcome"
      end
    end
  end
end
