# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :job do
    name { Forgery(:basic).text }
    target "mock"
    action "pass"
    heist
  end
end
