Elias::Container.namespace "persistence" do |persistence|
  persistence.finalize(:rom) do
    init do
      require "sequel"
      require "rom"

      use :monitor

      Sequel.database_timezone = :utc
      Sequel.application_timezone = :local

      rom_config = ROM::Configuration.new(
        :sql,
        persistence.settings.database_url,
        extensions: [:error_sql]
      )

      rom_config.plugin(:sql, relations: :instrumentation) do |p|
        p.notifications = notifications
      end

      rom_config.gateways[:default].use_logger persistence["logger"]

      persistence.register("config", rom_config)
    end

    start do
      config = persistence["persistence.config"]
      config.auto_registration(persistence.root.join("lib/persistence"))

      persistence.register("rom", ROM.container(config))
    end
  end
end
