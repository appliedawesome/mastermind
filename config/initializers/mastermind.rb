Mastermind::Config.setup do |config|
  config.goon :mock, Goon::Mock
  config.goon :ec2_server, Goon::Server::EC2
end