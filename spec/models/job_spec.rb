require 'spec_helper'

describe Job do
  describe "associations" do
    it { should belong_to(:heist) }
  end
  
  describe "validations" do
    before { FactoryGirl.create(:job) }
      
    it { should validate_uniqueness_of(:name).scoped_to(:heist_id) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:target_name) }
    it { should validate_presence_of(:action) }
    
    it "should have a valid factory" do
      FactoryGirl.build(:job).should be_valid
    end
  end
end
