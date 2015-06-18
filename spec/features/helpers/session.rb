module SessionHelpers

  def sign_in(email, password)
    User.create(email: 'test@test.com', password: 'test1234')
    visit '/users/sign_in'
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Log in'
    visit '/restaurants'
  end

  def leave_review(thoughts, rating)
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in 'Thoughts', with: thoughts
    select rating, from: 'Rating'
    click_button 'Leave Review'
  end
end