require 'spec_helper'

describe Heist do
  describe "associations" do
    it { should have_many(:jobs) }
  end
  
  describe "validations" do
    before { FactoryGirl.create(:heist) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:name) }
    
    it "should have a valid factory" do
      FactoryGirl.build(:heist).should be_valid
    end
  end
end
