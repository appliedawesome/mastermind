describe "user signs in" do
  let(:user) { FactoryGirl.create(:user) }
  
  it "should allow someone signed up to sign in" do
    user.confirm!
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'
    
    page.should have_content('Signed in successfully.')
  end   
end