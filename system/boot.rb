begin
  require 'pry-byebug'
rescue LoadError
  nil # do nothing
end

require_relative 'elias/container'

Elias::Container.finalize!

# Load sub-apps
app_paths = Pathname(__FILE__).dirname.join('../apps').realpath.join('*')
Dir[app_paths].each do |f|
  require "#{f}/system/boot"
end

require 'elias/application'
