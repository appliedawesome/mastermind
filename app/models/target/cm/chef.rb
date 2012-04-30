require 'spice'

class Target::CM::Chef < Target
  attribute :client_name, type: String
  attribute :key_file, type: String
  attribute :server_url, type: String
  
  def connection
    Spice::Connection.new(client_name: client_name, key_file: key_file, server_url: server_url)
  end
end