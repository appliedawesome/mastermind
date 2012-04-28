require 'spice'

class Target::CM::Chef < Target
  attribute :client_name, :type => String, :default => "dryan"
  attribute :key_file, :type => String, :default => "/Users/dan/.chef/dryan.pem"
  attribute :server_url, :type => String, :default => "http://chef.storm.doloreslabs.com:4000"
  
  def connection
    Spice::Connection.new(:client_name => client_name, :key_file => key_file, :server_url => server_url)
  end
end