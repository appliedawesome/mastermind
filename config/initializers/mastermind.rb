Mastermind::Config.setup do |config|
  config.target :mock, Target::Mock
  config.target :ec2_server, Target::Server::EC2
end