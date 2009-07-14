require "activesupport"

class Service
  cattr_accessor :root_dir, :default_target, :dependencies, :dependencies_root, :port
end

# define default values
Service.port = 4000
Service.dependencies = []
Service.dependencies_root = "../"
Service.default_target = "/app/thrift"

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].each { |ext| load ext }