namespace :tunnel do
  desc "Establish tunnel through #{Service.tunnel_gateway} for #{Service.name}"
  task :start do
    system "ssh -L #{Service.port}:localhost:#{Service.port} #{Service.tunnel_gateway} -fN"
    puts "started tunnel for #{Service.name}: ssh -L #{Service.port}:localhost:#{Service.port} #{Service.tunnel_gateway} -fN"
  end
  desc "Stop tunnel through #{Service.tunnel_gateway} for #{Service.name}"
  task :stop do
    system "ps -ef | grep \"ssh -L #{Service.port}:localhost:#{Service.port} #{Service.tunnel_gateway} -fN\" | grep -v \"grep\" | awk '{print $2}' | xargs kill -9"
    puts "stopped tunnel for #{Service.name}: ssh -L #{Service.port}:localhost:#{Service.port} #{Service.tunnel_gateway} -fN"
  end
  desc "status of tunnel through #{Service.tunnel_gateway} for #{Service.name}"
  task :status do
    result = %x[ps -ef | grep \"ssh -L #{Service.port}:localhost:#{Service.port} #{Service.tunnel_gateway} -fN\" | grep -v \"grep\"]
    unless result.blank?
      puts_green "tunnel of #{Service.name} is established\n--> #{result}"
    else
      puts_red "tunnel of #{Service.name} not established"
    end
  end
end
