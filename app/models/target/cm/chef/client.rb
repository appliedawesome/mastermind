class Target::CM::Chef::Client < Target::CM::Chef
  attribute :name, :type => String
  attribute :public_key, :type => String
  attribute :private_key, :type => String
  attribute :admin, :type => Boolean, :default => false
  
  action :create do
    requires :name, :admin
  end
  
  action :delete do
    requires :name
  end
  
end