# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    association :world
    name Faker::Name.name
    hp { Faker::Number.number(3) }
    mp { Faker::Number.number(3) }
    point_x { Faker::Number.number(3) }
    point_y { Faker::Number.number(3) }
    point_z { Faker::Number.number(3) }
  end
end
