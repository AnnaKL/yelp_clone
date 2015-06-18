require 'rails_helper'
require_relative 'helpers/session'
include SessionHelpers

feature 'restaurants' do
  before do
    visit('/')
    click_link('Sign up')
    fill_in('Email', with: 'test@example.com')
    fill_in('Password', with: 'testpassword')
    fill_in('Password confirmation', with: 'testpassword')
    click_button('Sign up')
  end
  context 'no restaurants have been added' do
    scenario 'should desplay a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content "No restaurants yet"
      expect(page).to have_link "Add a restaurant"
    end
  end

  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'KFC')
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating restaurants' do
    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
      expect(page).to have_content('KFC')
      expect(current_path).to eq '/restaurants'
    end

    context 'an invalid restaurant' do
      it 'does not let you submit a name that is too short' do
        visit '/restaurants'
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'kf'
        click_button 'Create Restaurant'
        expect(page).not_to have_css 'h2', text: 'kf'
        expect(page).to have_content 'error'
      end
    end
  end

  context 'viewing restaurants' do

    let!(:kfc) {Restaurant.create(name:'KFC')}

    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end
  end

  context 'editing restaurants' do
    before{Restaurant.create name: 'KFC'}

    scenario 'non creator cannot edit a restaurant' do
      visit '/restaurants'
      click_link('Edit KFC')
      expect(page).to have_content('KFC')
      expect(page).to have_content 'You can only edit a restaurant that you have created'
    end

    scenario 'the creator can edit a restaurant' do
      visit '/restaurants'
      create_restaurant('Trade')
      click_link('Edit Trade')
      fill_in('Name', with: 'Trade - the home of cakes')
      click_button 'Update Restaurant'
      expect(page).to have_content 'Trade - the home of cakes'
      expect(page).to have_content 'Restaurant edited successfully'
    end
  end

  context 'deleting restaurants' do
    before {Restaurant.create name: 'KFC'}

    scenario 'non creator cannot delete a restaurant' do
      visit '/restaurants'
      click_link 'Delete KFC'
      expect(page).to have_content 'KFC'
      expect(page).to have_content 'You can only delete a restaurant that you have created'
    end

    scenario 'only the creator can delete a restaurant' do
      create_restaurant('Trade')
      click_link 'Delete Trade'
      expect(page).not_to have_content 'Trade'
      expect(page).to have_content 'Restaurant deleted successfully'
    end
  end
end
