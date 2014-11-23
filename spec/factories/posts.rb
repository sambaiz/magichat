# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    association :user
    association :world
    text "MyString"
    point_x 1
    point_y 1
    point_z 1
  end
end
