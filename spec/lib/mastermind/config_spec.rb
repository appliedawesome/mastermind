require 'spec_helper'

describe Mastermind::Config do
  before :each do
    class Target::Foo < Target; end
    class Target::Bar < Target; end
  end
  
  context 'registration' do
    describe '.register_target' do
      it "should register a target" do
        Mastermind::Config.register_target(:foo, Target::Foo)
        Mastermind::HitList.targets[:foo].should be Target::Foo
      end
    end    
  
    describe '.register_targets' do
      it 'should register multiple targets' do
        Mastermind::Config.register_targets(foo: Target::Foo, bar: Target::Bar)
        Mastermind::HitList.targets[:foo].should be Target::Foo
        Mastermind::HitList.targets[:bar].should be Target::Bar
      end
    
    end

  end
  
  context 'deregistration' do
    describe '.deregister_target' do
      before :each do
        Mastermind::Config.register_targets(foo: Target::Foo, bar: Target::Bar)
      end
      
      it "should deregister a target" do
        Mastermind::Config.deregister_target(:bar)
        Mastermind::HitList.targets[:bar].should be_nil
      end
      
      it 'should only only deregister specified targets' do
        Mastermind::Config.deregister_target(:foo)
        Mastermind::HitList.targets[:foo].should be_nil
        Mastermind::HitList.targets[:bar].should_not be_nil
      end
    end
    
    describe '.deregister_targets' do
      before :each do
        Mastermind::Config.register_targets(foo: Target::Foo, bar: Target::Bar)
      end
      
      it 'should deregister multiple targets' do
        Mastermind::Config.deregister_targets(:foo, :bar)
        Mastermind::HitList.targets[:foo].should be_nil
        Mastermind::HitList.targets[:bar].should be_nil
      end
    end
  end
end