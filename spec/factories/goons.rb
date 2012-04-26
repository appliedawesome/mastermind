# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :target, :class => Target::Mock do
    name "mock_target"
    message "hello world"
    action :run
  end
end
