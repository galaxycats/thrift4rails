namespace :service do
  
  desc "Start server of service on port #{Service.port}"
  task :start do
    system "script/server -p #{Service.port}"
  end
  
end