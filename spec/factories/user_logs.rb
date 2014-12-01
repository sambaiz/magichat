# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_log do
    association :user
    association :post
  end
end
