# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    association :user
    association :world
    text { Faker::Lorem.sentence }
    point_x { Faker::Number.number(3) }
    point_y { Faker::Number.number(3) }
    point_z { Faker::Number.number(3) }
  end
end
