require 'spec_helper'

describe Target::Server::EC2 do
  it { should have_allowed_actions(:create, :destroy, :start, :stop, :restart) }  
end