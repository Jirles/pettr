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
  # dogs index & show => public - dogs index should have link in navbar
    # dogs index also has a filter option for results ordering => recently update, highest rating
    # maybe even a search feature?
  # dogs new, edit, update, create, destroy all namespaced under owner
    # can be linked to from user profile page
    # or the navbar if a dog exists

end
