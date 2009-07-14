namespace :thrift do
  
  desc "Show configuration of service"
  task :config do
    puts "Service.root_dir: #{Service.root_dir}"
    puts "Service.dependencies: #{Service.dependencies}"
    puts "Service.dependencies_root: #{Service.dependencies_root}"
    puts "Service.default_target: #{Service.default_target}"
    puts "Service.port: #{Service.port}"
  end
  
  namespace :generate do
  
    desc "Generate all service-definitions (own and dependent)"
    task :all do
      Rake::Task["thrift:generate:self"].invoke
      Rake::Task["thrift:generate:dependencies"].invoke
    end

    desc "Generate own service-definitions"
    task :self do
      target = ENV["TARGET"] || ".#{Service.default_target}"
      puts "Generating self..."
      if File.exists?(File.join(Service.root_dir, "config/service_definition.thrift"))
        puts "  -> generating service-definitions: config/service_definition.thrift"
        system "thrift --gen rb:rails -o #{target} #{File.join(Service.root_dir, "config/service_definition.thrift")}"
      else
        puts "  -> no service-definitions"
      end
      if File.exists?(File.join(Service.root_dir, "config/service_includes.thrift"))
        puts "  -> generating service-includes: config/service_includes.thrift"
        system "thrift --gen rb:rails -o #{target} #{File.join(Service.root_dir, "config/service_includes.thrift")}"
      else
        puts "  -> no service-includes"
      end
      puts "...done"
    end
    
    desc "Generate all dependent service-definitions"
    task :dependencies do
      if Service.dependencies.blank?
        puts "No dependencies defined"
      else
        puts "Generating dependencies..."
        Service.dependencies.each do |dependency|
          puts "  -> generating dependency: #{dependency}"
          system "cd #{File.join(Service.dependencies_root, dependency)} && rake thrift:generate:self TARGET=#{File.join(Service.root_dir, Service.default_target)}"
        end
        puts "...done"
      end
    end
    
  end
end