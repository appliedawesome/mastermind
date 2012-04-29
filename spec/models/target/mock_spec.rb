require 'spec_helper'

describe Target::Mock do
  it { should have_allowed_actions(:pass, :fail) }
end