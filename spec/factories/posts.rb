# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    text "MyString"
    user_id 1
    world_id 1
    point_x 1
    point_y 1
    point_z 1
  end
end
