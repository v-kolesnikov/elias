require "logger"

Elias::Container.finalize :logger do |container|
  logger = Logger.new(container.root.join("log/#{container.config.env}.log"))
  container.register "logger", logger
end
