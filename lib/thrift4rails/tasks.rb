require "activesupport"

class Service
  cattr_accessor :root_dir, :default_target, :dependencies, :dependencies_root, :port, :name, :tunnel_gateway
end

# define default values
Service.port = 4000
Service.dependencies = []
Service.dependencies_root = "../"
Service.default_target = "/app/thrift"

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].each { |ext| load ext }

def puts_red(out)
  puts "\e[31m#{out}\e[0m"
end

def puts_green(out)
  puts "\e[32m#{out}\e[0m"
end