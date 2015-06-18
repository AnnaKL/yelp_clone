require 'rails_helper'

feature 'reviewing' do
  before {Restaurant.create name: 'KFC'}


  scenario 'allows users to leave a review using a form' do

  visit '/restaurants'

  click_link 'Sign_in'
  fill_in('Email', with: 'test@example.com')
  fill_in('Password', with: 'testpassword')
  click_button 'Log in'
  click_link 'Review KFC'
  fill_in 'Thoughts', with: "so, so"
  select '3', from: 'Rating'
  click_button 'Leave Review'
  expect(current_path).to eq '/restaurants'
  expect(page).to have_content('so, so')
  end

  def sign_in(email="test@test.com", password="testpassword")
    # User.create(email: 'test@test.com', password: 'testpassword')
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      click_button 'Log in'
    end
end
