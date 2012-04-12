# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :goon, :class => Goon::Mock do
    name "mock_goon"
    message "hello world"
    action :run
  end
end
