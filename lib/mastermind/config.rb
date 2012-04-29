module Mastermind::Config
  extend self
  
  def setup
    yield self
    self
  end
  
  def register_target(type, target_class)
    ::HitList.targets[type] = target_class
    target_class.type type
  end
    
  def chef
    @chef ||= Chef.new
    yield @chef if block_given?
    @chef
  end
  
  def ec2
    @ec2 ||= EC2.new
    yield @ec2 if block_given?
    @ec2
  end
  
  class Chef
    attr_accessor :client_name, :key_file, :server_url
  end
  
  class EC2
    attr_accessor :aws_access_key_id, :aws_secret_access_key
  end
end
