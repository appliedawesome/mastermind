Mastermind::Config.setup do |config|
  config.target :mock, Target::Mock
  
  # EC2
  config.target :ec2_server, Target::Server::EC2
  
  # Chef
  config.target :chef_client, Target::CM::Chef::Client
end