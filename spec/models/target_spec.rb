require 'spec_helper'

describe Target do
  describe 'class methods' do
    describe '.allowed_actions' do
      it { Target.allowed_actions.should include(:nothing) }
    end
  end
end
