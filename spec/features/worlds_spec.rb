require 'rails_helper'

feature 'World walking' do
  scenario 'adds a new world' do
    visit root_path
    user = build(:user, world: nil)
    expect{
      fill_in 'user_name', with: user.name
      click_button '詠唱'
    }.to change(World, :count).by(1)
    expect(current_path).to match(chat_path(''))
  end

  scenario 'fail to add a new world' do
    visit root_path
    user = create(:user)
    expect{
      fill_in 'user_name', with: user.name
      click_button '詠唱'
    }.not_to change(User, :count)
    expect(current_path).to eq root_path
    expect(page).to have_content 'Name has already been taken'
  end
end