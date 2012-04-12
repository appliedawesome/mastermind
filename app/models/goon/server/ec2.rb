require 'fog'

class Goon::Server::EC2 < Goon
  default_action :create
  
  attribute :aws_access_key_id, :type => String, :required => true
  attribute :aws_secret_access_key, :type => String, :required => true
  attribute :image_id, :type => String
  attribute :key_name, :type => String
  attribute :ami_launch_index, :type => Numeric
  attribute :availability_zone, :type => String, :default => 'us-east-1a'
  attribute :region, :type => String, :default => 'us-east-1'
  attribute :block_device_mapping, :type => Object
  attribute :client_token, :type => String
  attribute :dns_name, :type => String
  attribute :groups, :type => Object, :default => [ 'default' ]
  attribute :flavor_id, :type => String
  attribute :instance_id, :type => String
  attribute :kernel_id, :type => String
  attribute :created_at, :type => DateTime
  attribute :monitoring, :type => Boolean, :default => false
  attribute :placement_group, :type => String
  attribute :platform, :type => String
  attribute :product_codes, :type => Object
  attribute :private_dns_name, :type => String
  attribute :private_ip_address, :type => String
  attribute :public_ip_address, :type => String
  attribute :ramdisk_id, :type => String
  attribute :reason, :type => String
  attribute :root_device_name, :type => String
  attribute :root_device_type, :type => String
  attribute :state, :type => String
  attribute :state_reason, :type => Object
  attribute :subnet_id, :type => String
  attribute :tenancy, :type => String
  attribute :tags, :type => Object
  attribute :user_data, :type => String
  
  validates_presence_of :aws_access_key_id, :aws_secret_access_key
  
  def connection
    Fog::Compute.new(
      :provider => 'AWS',
      :aws_access_key_id => aws_access_key_id,
      :aws_secret_access_key => aws_secret_access_key
    )
  end
  
  action :create, 
         :requires => [:image_id, :flavor_id, :key_name, :availability_zone, :groups] do
    
    Mastermind::Log.info "Creating EC2 server"
    
    server = connection.servers.create(
      :image_id => image_id,
      :flavor_id => flavor_id,
      :groups => groups,
      :key_name => key_name,
      :availability_zone => availability_zone,
      :tags => tags
    )
    server.wait_for { ready? }
    attributes = server.attributes
  end

  action :destroy, :requires => :instance_id do
    server = connection.servers.get(instance_id)
    server.destroy
    Mastermind::Log.info "Destroying EC2 server #{instance_id}"
    server.wait_for { state == 'terminated' }
    attributes = server.attributes
  end

  action :stop, :requires => :instance_id do
    server = connection.servers.get(instance_id)
    server.stop
    Mastermind::Log.info "Stopping EC2 server #{instance_id}"
    server.wait_for { state == 'stopped' }
    attributes = server.attributes
  end

  action :start, :requires => :instance_id do
    server = connection.servers.get(instance_id)
    server.start
    Mastermind::Log.info "Starting EC2 server #{instance_id}"
    server.wait_for { state == 'running' }
    attributes = server.attributes
  end
  
  action :restart, :requires => :instance_id do
    server = connection.servers.get(instance_id)
    server.stop
    Mastermind::Log.info "Stopping EC2 server #{instance_id}"
    server.wait_for { state == 'stopped' }
    server.start
    Mastermind::Log.info "Starting EC2 server #{instance_id}"
    server.wait_for { state == 'running' }
    attributes = server.attributes
  end  
end
