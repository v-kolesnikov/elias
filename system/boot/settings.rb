Elias::Container.finalize :settings do |container|
  init do
    require 'elias/settings'
  end

  start do
    settings = Elias::Settings.load(container.config.root, container.config.env)
    container.register 'settings', settings
  end
end
