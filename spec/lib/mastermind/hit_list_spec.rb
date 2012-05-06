require 'spec_helper'

describe Mastermind::HitList do
  before do
    Mastermind::Config.setup do |c|
      c.register_target :mock, Target::Mock
    end
  end
    
  it "should keep a list of registered targets" do
    Mastermind::HitList.targets[:mock].should == Target::Mock
  end
  
  it "should allow indifferent access" do
    Mastermind::HitList.targets[:mock].should == Target::Mock
    Mastermind::HitList.targets['mock'].should == Target::Mock
  end
end