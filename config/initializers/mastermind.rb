Mastermind::Config.setup do |config|
  
  # Register targets in the HitList
  config.register_target :mock, Target::Mock
  config.register_target :ec2_server, Target::Server::EC2
  config.register_target :chef_client, Target::CM::Chef::Client
  
  # Chef config
  config.chef do |chef|
    chef.client_name          = ENV['CHEF_CLIENT_NAME']
    chef.key_file             = ENV['CHEF_KEY_FILE']
    chef.server_url           = ENV['CHEF_SERVER_URL']
  end
  
  # EC2 config
  config.ec2 do |ec2|
    ec2.aws_access_key_id     = ENV['AWS_ACCESS_KEY_ID']
    ec2.aws_secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
  end

end