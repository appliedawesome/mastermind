module RequestMacros
  def login(user)
    page.driver.post user_session_path,
      :user => {:email => user.email, :password => user.password}
  end
  
  def logout(user)
    page.driver.delete destroy_user_session_path
  end
end
