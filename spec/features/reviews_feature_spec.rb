require 'rails_helper'
require_relative 'helpers/session'
include SessionHelpers

feature 'reviewing' do
  before {Restaurant.create name: 'KFC'}


  scenario 'allows users to leave a review using a form' do

  visit '/restaurants'

  sign_in('test@test.com', 'test1234')
  leave_review('so, so', '2')
  expect(current_path).to eq '/restaurants'
  expect(page).to have_content('so, so')
  end

  scenario 'allows only one review per user per restaurant' do
    visit '/restaurants'
    sign_in('test@test.com', 'test1234')
    leave_review('so, so', '2')
    leave_review('amazeballs', '5')
    expect(page).to have_content('You have already reviewed this restaurant')
  end

end



