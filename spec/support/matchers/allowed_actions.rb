RSpec::Matchers.define :have_allowed_actions do |expected|
  match do |actual|
    actual.class.allowed_actions.include?(expected)
  end  
end
      
      