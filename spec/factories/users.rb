# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :random_email do 
    Forgery::Internet.email_address
  end
  
  factory :user do
    email { generate(:random_email) }
    password 'password'
    password_confirmation 'password'
    confirmed_at { Time.now }
  end
end
