# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :henchman, :class => Henchman::Mock do
    name "mock_henchman"
    message "hello world"
    action :run
  end
end
