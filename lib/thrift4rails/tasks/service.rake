namespace :service do
  
  desc "Start server of service on port #{Service.port}"
  task :start do
    add_rails_env = ""
    if ENV["RAILS_ENV"]
      add_rails_env = " -e #{ENV["RAILS_ENV"]}"
    end  
    system "script/server -p #{Service.port}#{add_rails_env}"
  end
  
end