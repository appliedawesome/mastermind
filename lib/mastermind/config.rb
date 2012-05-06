module Mastermind::Config
  extend self
  
  def setup
    yield self
    self
  end
  
  def register_target(type, target_class)
    ::Mastermind::HitList.targets[type] = target_class
    target_class.type type
  end
  
  def register_targets(targets)
    raise ArgumentError unless targets.is_a?(Hash)
    targets.each do |type, target_class|
      register_target(type, target_class)
    end
  end
  
  def deregister_target(type)
    ::Mastermind::HitList.targets[type] = nil
  end
  
  def deregister_targets(*targets)
    targets = targets.flatten!
    raise ArgumentError unless targets && targets.is_an?(Array)
    targets.each do |target|
      deregister_target(target)
    end
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
