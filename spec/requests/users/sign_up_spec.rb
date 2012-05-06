require 'spec_helper'

describe "user sign up" do
  let(:user) { FactoryGirl.build(:user) }

  it "should allow someone to sign up" do
    visit sign_up_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password_confirmation
    click_button 'Sign up'
    User.where(:email => user.email).first.should_not be_nil
    user.should_not be_nil
  end
end