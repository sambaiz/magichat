# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    association :world
    name "MyString"
    hp 1
    mp 1
    point_x 1
    point_y 1
    point_z 1
  end
end
