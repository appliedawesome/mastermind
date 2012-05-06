module ControllerMacros
  def sign_in_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = Factory.create(:user)
      # or set a confirmed_at inside the factory. Only necessary if you
      # are using the confirmable module
      user.confirm!
      sign_in user
    end
  end
end
