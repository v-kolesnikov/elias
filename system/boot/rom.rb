# rubocop:disable Metrics/BlockLength
Elias::Container.namespace 'persistence' do |container|
  container.finalize :rom do
    init do
      require 'sequel'
      require 'rom'
      require 'rom/sql'

      use :settings
      use :monitor

      ROM::SQL.load_extensions :postgres

      Sequel.database_timezone = :utc
      Sequel.application_timezone = :local

      rom_config = ROM::Configuration.new(
        :sql,
        settings.database_url,
        extensions: %i[error_sql pg_array pg_json],
        after_connect: ->(conn) do
          conn.execute("SET SEARCH_PATH TO #{settings.database_schema}")
        end
      )

      rom_config.plugin :sql, relations: :instrumentation do |plugin_config|
        plugin_config.notifications = notifications
      end

      rom_config.plugin :sql, relations: :auto_restrictions

      container.register 'config', rom_config
      container.register 'db', rom_config.gateways[:default].connection
    end

    start do
      config = container['persistence.config']
      config.auto_registration container.root.join('lib/persistence')

      container.register 'rom', ROM.container(config)
    end
  end
end
