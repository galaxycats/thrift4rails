require "activesupport"

class Service
  cattr_accessor :root_dir, :default_target, :dependencies, :dependencies_root
end

Service.root_dir ||= File.join(File.dirname(__FILE__), "../../")
Service.dependencies ||= []
Service.dependencies_root ||= "../"
Service.default_target ||= "/app/thrift"

namespace :thrift do
  
  desc "Show configuration of service"
  task :config do
    puts "Service.root_dir: #{Service.root_dir}"
    puts "Service.dependencies: #{Service.dependencies}"
    puts "Service.dependencies_root: #{Service.dependencies_root}"
    puts "Service.default_target: #{Service.default_target}"
  end
  
  namespace :generate do
  
    desc "Generate all service-definitions (own and dependent)"
    task :all do
      Rake::Task["thrift:generate:dependencies"].invoke
      Rake::Task["thrift:generate:self"].invoke
    end

    desc "Generate own service-definitions"
    task :self do
      target = ENV["TARGET"] || ".#{Service.default_target}"
      puts "generating self: thrift --gen rb:rails -o #{target} #{File.join(Service.root_dir, "config/service_definition.thrift")}"
      system "thrift --gen rb:rails -o #{target} #{File.join(Service.root_dir, "config/service_definition.thrift")}"
      system "thrift --gen rb:rails -o #{target} #{File.join(Service.root_dir, "config/service_includes.thrift")}" if File.exists?(File.join(Service.root_dir, "config/service_includes.thrift"))
    end
    
    desc "Generate all dependent service-definitions"
    task :dependencies do
      Service.dependencies.each do |dependency|
        puts "cd #{File.join(Service.dependencies_root, dependency)} && rake thrift:generate:self TARGET=#{File.join(Service.root_dir, Service.default_target)}"
        `cd #{File.join(Service.dependencies_root, dependency)} && rake thrift:generate:self TARGET=#{File.join(Service.root_dir, Service.default_target)}`
      end
    end
    
  end
end