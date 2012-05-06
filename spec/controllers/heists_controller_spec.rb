require 'spec_helper'

describe HeistsController do

  def mock_heist(stubs={})
    @mock_heist ||= mock_model(Heist, stubs).as_null_object
  end
  
  describe "GET :index" do
    let(:heist) { FactoryGirl.create(:heist) }
    
    before do
      Heist.should_receive(:all).and_return([ heist ])
      get :index, :format => :json
    end
    
    it { should respond_with(200) }
    it { should assign_to(:heists) }
    it { [ heist ].to_json.should be_json_eql(response.body) }
  end
  
  # 
  # describe "GET :show'" do
  #   let(:heist) { FactoryGirl.create(:heist) }
  #   
  #   before do
  #     Heist.should_receive(:find).and_return(heist)
  #     get :show, :id => heist.id 
  #   end
  #   
  #   it { should respond_with(200) }
  #   it { should assign_to(:heist).with_kind_of(Heist) }
  #   it { response.body.should == { name: heist.name, profile: heist.profile }.to_json }
  # end
  # 
  # describe 'POST :create' do
  #   context 'valid account' do
  #     let(:valid) { FactoryGirl.attributes_for(:heist).stringify_keys }
  #     
  #     before do
  #       Heist.stub(:new).with(valid) { mock_heist(:save => true) }
  #       post :create, :heist => valid
  #     end
  # 
  #     it { should respond_with(201) }
  #     it { should assign_to(:heist).with_kind_of(Heist) }
  #   end
  # end

end
