# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :heist do
    name { Forgery(:basic).text }
    profile 'job_message' => "BAR!"
  end
  
end
