require 'rails_helper'

RSpec.describe 'Dog Features', :type => :feature do
  before do
    set_variables
  end

  describe 'index page' do
    before do
      signup_as_bob_belcher
    end

    it 'has an index page' do
      visit dogs_path
      expect(page.status_code).to eq(200)
    end

    it 'has a list of basic information on dog profiles' do
      visit dogs_path

      expect(page).to have_content("Bandit")
      expect(page).to have_content("Bulldog")
      expect(page).to have_content("Durham, North Carolina")
      expect(page).to have_content("4.5 stars")
    end

    it 'has links to a dogs profile' do
      visit dogs_path
      click_link 'Bandit'

      expect(page.status_code).to eq(200)
      expect(page.current_path).to eq(dog_path(@bandit))
    end

    it 'cannot be accessed unless a user is logged in' do
      click_link "LogOut"

      visit dogs_path
      expect(page.current_path).to eq(login_path)
      expect(page).to have_content("Please login or signup to view more content.")
    end
  end

  describe 'show page' do

    context 'accessed by non-affiliated user' do
      before do
        signup_as_bob_belcher
      end

      it 'shows a dogs information and the pettings it has been involved in if any' do
        visit dog_path(@bandit)

        expect(page).to have_content(@bandit.name)
        expect(page).to have_content("#{@bandit.user_rating} stars")
        expect(page).to have_link("BEST DOG EVAAA!!!!")
        expect(page).to have_link("Very happy, but very high energy, overall a good dog")
      end

      it 'links to individual pettings' do
        visit dog_path(@bandit)
        click_link "BEST DOG EVAAA!!!!"

        expect(page.current_path).to eq(petting_path(@linda_bandit))
      end

      it 'does not display edit or delete options' do
        visit dog_path(@buck)

        expect(page).not_to have_link("Edit")
        expect(page).not_to have_link("Delete")
      end

      it 'only lets logged in users access it' do
        click_link "LogOut"
        visit dog_path(@buck)

        expect(page.current_path).to eq(login_path)
        expect(page).to have_content("Please login or signup to view more content.")
      end

      it 'does not allow an unaffiliated user to navigate to the owners show page' do
        visit owner_dog_path(@buck)

        expect(page).to have_content("Sorry, but you do not have access to that page.")
        expect(page.current_path).to eq(dogs_path)
      end
    end

    context 'accessed by owner' do
      before do
        visit login_path
        fill_in(:session_email, with: "jquest@cartoons.com")
        fill_in(:session_password, with: "password")
        click_button "LogIn"
      end

      it 'redirects owner to owner show page' do
        visit dog_path(@bandit)

        expect(page.current_path).to eq(owner_dog_path(@bandit))
      end
    end
  end


  # dogs index & show => public - dogs index should have link in navbar
    # dogs index also has a filter option for results ordering => recently update, highest rating
    # maybe even a search feature?
  # dogs new, edit, update, create, destroy all namespaced under owner
    # can be linked to from user profile page
    # or the navbar if a dog exists

end
