require 'spec_helper'

describe Target::CM::Chef::Client do
  it { should have_allowed_actions(:create, :destroy) }  
  
  describe '#create' do
  end 
end