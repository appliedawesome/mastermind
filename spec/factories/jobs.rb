# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :job do
    name { Forgery(:basic).text }
    target_name "mock"
    action "pass"
    profile :message => "FOOOO"
    heist
  end
  
  factory :job_with_heist_profile, :class => Job do
    name { Forgery(:basic).text }
    target_name "mock"
    action "pass"
    profile :message => "{{job_message}}"
    association :heist, :factory => :heist_with_profile
  end
  
  factory :job_with_bad_heist_profile, :class => Job do
    name { Forgery(:basic).text }
    target_name "mock"
    action "pass"
    profile :message => "{{missing_message}}"
    association :heist, :factory => :heist_with_profile
  end
end
  