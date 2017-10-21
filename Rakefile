# rubocop:disable Metrics/BlockLength
require 'bundler/setup'

require 'byebug' unless ENV['RACK_ENV'] == 'production'
require 'rom/sql/rake_task'
require 'shellwords'
require_relative 'system/elias/container'

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new :spec
  task default: [:spec]
rescue LoadError
end

def db
  Elias::Container['persistence.db']
end

def settings
  Elias::Container[:settings]
end

task :environment do
  Elias::Container.finalize!
end

task :console do
  load './bin/console'
end

namespace :db do
  task console: :environment do
    system("psql #{Shellwords.escape(settings[:database_url])}")
  end

  task :setup do
    Elias::Container.init :rom
  end

  desc 'Prints current schema version'
  task version: :setup do
    version =
      if db.tables.include?(:schema_migrations)
        db[:schema_migrations].order(:filename).last[:filename]
      else
        'not available'
      end

    puts "Current schema version: #{version}"
  end

  desc 'Perform migration up to latest migration available'
  task :migrate do
    # Enhance the migration task provided by ROM

    # Once it finishes, dump the db structure
    Rake::Task['db:structure:dump'].execute

    # And print the current migration version
    Rake::Task['db:version'].execute
  end

  namespace :structure do
    desc 'Dump database structure to db/structure.sql'
    task :dump do
      if system('which pg_dump', out: File::NULL)
        system(
          %(pg_dump -s -x -O #{Shellwords.escape(db.url)} > db/structure.sql)
        )
      end
    end
  end

  desc 'Load seed data into the database'
  task :seed do
    seed_data = File.join('db', 'seed.rb')
    load(seed_data) if File.exist?(seed_data)
  end

  desc 'Load a small, representative set of data (for development)'
  task :sample_data do
    sample_data = File.join('db', 'sample_data.rb')
    load(sample_data) if File.exist?(sample_data)
  end
end
