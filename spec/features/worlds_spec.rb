require 'rails_helper'

feature 'World walking' do
  scenario 'input unique user name and call' do
    visit root_path
    user = build(:user, world: nil)
    expect{
      fill_in 'user_name', with: user.name
      click_button '詠唱'
    }.to change(World, :count).by(1)
    expect(current_path).to match(chat_path(''))
  end

  scenario 'input non-unique user name and call' do
    visit root_path
    user = create(:user)
    expect{
      fill_in 'user_name', with: user.name
      click_button '詠唱'
    }.not_to change(User, :count)
    expect(current_path).to eq root_path
    expect(page).to have_content 'Name has already been taken'
  end

  scenario 'input blank user name and call' do
    visit root_path
    expect{
      fill_in 'user_name', with: ''
      click_button '詠唱'
    }.not_to change(User, :count)
    expect(current_path).to eq root_path
    expect(page).to have_content "Name can't be blank"
  end

  # UGOKAN
  #scenario 'input text and send', js: true do
  #  user = build(:user, world: nil)
  #  visit root_path
  #  fill_in 'user_name', with: user.name
  #  click_button '詠唱'
  #  fill_in 'msgbody', with: "テスト"
  #  click_button '送信'
  #  expect(page).to have_content "テスト", :wait => 10
  #end
end