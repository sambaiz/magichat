# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :world do
    code { World.create_code }
  end
end
