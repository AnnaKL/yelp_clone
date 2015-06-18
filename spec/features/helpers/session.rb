module SessionHelpers

  def sign_in
    User.create(email: 'test@test.com', password: 'test1234')
    visit '/users/sign_in'
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: 'test1234'
    click_button 'Log in'
    visit '/restaurants'
  end
end