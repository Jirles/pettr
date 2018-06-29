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
      visit signup_path
      fill_in(:user_first_name, with: "Bob")
      fill_in(:user_last_name, with: "Belcher")
      fill_in(:user_email, with: "bob@burgers.com")
      fill_in(:user_password, with: "burgers")
      click_button "SignUp"

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
      User.create(first_name: "Louise", last_name: "Belcher", email: "lb@burgers.com", password: 'secret')
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
      @louise = User.create(first_name: "Louise", last_name: "Belcher", email: "lb@burgers.com", password: 'secret')
    end

    it 'has a form  with fields for email and password' do
      visit login_path

      expect(page).to have_selector('form')
      fill_in(:session_email, with: 'lb@burgers.com')
      fill_in(:session_password, with: 'secret')
    end

    it 'logs a user in and redirects them to the user show page' do
      visit login_path
      fill_in(:session_email, with: 'lb@burgers.com')
      fill_in(:session_password, with: 'secret')
      click_button "LogIn"

      expect(page).to have_content("Louise Belcher")
      expect(page.current_path).to eq(user_path(@louise))
    end
  end
end
