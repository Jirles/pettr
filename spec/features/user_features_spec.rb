require 'rails_helper'

RSpec.describe 'User Features', :type => :feature do
  context 'SignUp page' do
    it 'has a form to create a new user' do
      visit signup_path

      expect(page.status_code).to eq(200)
      expect(page).to have_content("SignUp")
      expect(page).to have_selector('form')
    end

    it 'has fields for first_name, last_name, email, and password' do
      visit signup_path
      fill_in(:user_first_name, with: "Bob")
      fill_in(:user_last_name, with: "Belcher")
      fill_in(:user_email, with: "bob@burgers.com")
      fill_in(:user_password, with: "burgers")
    end

    it 'creates a new user and redirects the user to their show page' do
      signup_as_bob_belcher

      expect(User.last.full_name).to eq("Bob Belcher")
      expect(page.current_path).to eq(user_path(User.last))
    end

    it 'does not create a user without a first name and shows an error message' do
      visit signup_path
      fill_in(:user_last_name, with: "Belcher")
      fill_in(:user_email, with: "zombie_butts@burgers.com")
      fill_in(:user_password, with: "iheartbutts")
      click_button "SignUp"

      expect(page.current_path).to include('/signup')
      expect(page).to have_content("First name can't be blank")
      expect(User.all.size).to eq(0)
    end

    it 'does not create a user without a last name and shows an error message' do
      visit signup_path
      fill_in(:user_first_name, with: "Tina")
      fill_in(:user_email, with: "zombie_butts@burgers.com")
      fill_in(:user_password, with: "iheartbutts")
      click_button "SignUp"

      expect(page.current_path).to include('/signup')
      expect(page).to have_content("Last name can't be blank")
      expect(User.all.size).to eq(0)
    end

    it 'does not create a user without an email and shows an error message' do
      visit signup_path
      fill_in(:user_first_name, with: "Tina")
      fill_in(:user_last_name, with: "Belcher")
      fill_in(:user_password, with: "iheartbutts")
      click_button "SignUp"

      expect(page.current_path).to include('/signup')
      expect(page).to have_content("Email can't be blank")
      expect(User.all.size).to eq(0)
    end

    it 'does not create a user with an email that is already in the database and shows an error message' do
      create_louise_belcher
      visit signup_path
      fill_in(:user_first_name, with: "Linda")
      fill_in(:user_last_name, with: "Belcher")
      fill_in(:user_email, with: "lb@burgers.com")
      fill_in(:user_password, with: "burgers")
      click_button "SignUp"

      expect(page.current_path).to include('/signup')
      expect(page).to have_content("Email has already been taken")
      expect(User.last.first_name).to eq("Louise")
    end

    it 'does not create a user without a password and shows an error message' do
      visit signup_path
      fill_in(:user_first_name, with: "Tina")
      fill_in(:user_last_name, with: "Belcher")
      fill_in(:user_email, with: "zombie_butts@burgers.com")
      click_button "SignUp"

      expect(page.current_path).to include('/signup')
      expect(page).to have_content("Password can't be blank")
      expect(User.all.size).to eq(0)
    end
  end

  context 'LogIn page' do
    before do
      @louise = create_louise_belcher
    end

    it 'has a form  with fields for email and password' do
      visit login_path

      expect(page).to have_selector('form')
      fill_in(:session_email, with: 'lb@burgers.com')
      fill_in(:session_password, with: 'secret')
    end

    it 'logs a user in and redirects them to the user show page' do
      login_as_louise

      expect(page).to have_content("Louise Belcher")
      expect(page.current_path).to eq(user_path(@louise))
    end

    it 'does not let a user log in without an email and shows an error message' do
      visit login_path
      fill_in(:session_password, with: 'secret')
      click_button "LogIn"

      expect(page).to have_content("Email/password can't be blank")
      expect(page.current_path).to include('/login')
    end

    it 'does not let a user log in without a password and shows an error message' do
      visit login_path
      fill_in(:session_email, with: 'lb@burgers.com')
      click_button "LogIn"

      expect(page).to have_content("Email/password can't be blank")
      expect(page.current_path).to include('/login')
    end
  end

  context 'Show Page' do
    before do
      signup_as_bob_belcher
    end

    it 'shows a users full name' do
      expect(page).to have_content("Bob Belcher")
    end

    it 'cannot be seen if a user is logged out' do
      click_button 'LogOut'
      visit '/users/1'

      expect(page.current_path).to eq(root_path)
    end
  end

  context 'Logout functions' do
    before do
      create_louise_belcher
      login_as_louise
    end

    it 'logs the user out and redirects them to the homepage' do
      click_button "LogOut"

      expect(page.current_path).to eq(root_path)
    end
  end
end
