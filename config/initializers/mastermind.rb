Mastermind::Config.setup do |config|
  config.henchman :mock, Henchman::Mock
  config.henchman :ec2_server, Henchman::Server::EC2
end