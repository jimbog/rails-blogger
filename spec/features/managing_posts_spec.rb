feature 'Managing blog posts' do
  scenario 'Guests cannot create posts' do
    visit root_path
    click_link 'New Post'

    expect(page).to have_content 'You need to sign in'
  end

  scenario 'Logged in users can create posts' do
    visit new_post_path

    User.create(email: "admin@example.com", password: "password")

    fill_in 'Email', with: "admin@example.com"
    fill_in 'Password', with: "password"
    click_button 'Sign in'

    expect(page).to have_content 'New post'
  end
end
