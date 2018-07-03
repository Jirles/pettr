require 'rails_helper'

RSpec.describe 'Petting Features', :type => :feature do
  before do
    set_variables
  end

  context 'index page' do
    it 'shows all of the pettings' do
      visit pettings_path

      expect(page).to have_content("Linda Belcher pet Bandit!")
      expect(page).to have_link("BEST DOG EVAAA!!!!")
      expect(page).to have_content("5.0/5.0 would do it again")
      expect(page).to have_content('Ocean City, New Jersey')
    end

    it 'is the root page of the application' do
      visit root_path

      expect(page).to have_link("BEST DOG EVAAA!!!!")
      expect(page).to have_link("Seemed a little wild...")
    end

    it 'has links to a pettings individual show page' do
      create_louise_belcher
      login_as_louise

      visit root_path
      click_link "Seemed a little wild..."

      expect(page.current_path).to eq(petting_path(@jquest_whitefang))
    end
  end

  context 'show page' do
    before do
      signup_as_bob_belcher
    end

    it 'shows petting details' do
      visit petting_path(@lightning_bandit)

      expect(page).to have_content("Very happy, but very high energy, overall a good dog")
      expect(page).to have_content("Breed: Bulldog")
      expect(page).to have_content("Location: Raleigh, North Carolina")
    end
  end

  context 'create petting' do
    before do
      signup_as_bob_belcher
    end
    it 'can only be accessed if you are logged in' do
      click_button "LogOut"

      visit new_petting_path
      expect(page.current_path).to eq(root_path)
    end

    it 'has a form with petting fields' do
      visit new_petting_path

      expect(page).to have_selector('form')
      expect(page).to have_content("Select a dog's Pettr profile:")
      expect(page).to have_field(:petting_pet_rating_0)
      expect(page).to have_field(:petting_dog_id)
      expect(page).to have_button("Pettr")
    end

    it 'creates a new petting instance using a dogs profile and redirects the user to the petting show page' do
      visit new_petting_path
      select("White Fang", from: :petting_dog_id)
      fill_in(:petting_location, with: "Bob's Burgers Restaurant")
      choose(:petting_pet_rating_3)
      fill_in(:petting_description, with: "Not sure where this dog came from, but Louise liked it.")
      click_button "Pettr"

      expect(page.current_path).to eq(petting_path(Petting.last))
      expect(page).to have_content("Breed: Siberian Husky")
      expect(page).to have_content("3.0/5.0 would do it again")
      expect(Petting.last.description).to eq("Not sure where this dog came from, but Louise liked it.")
    end
  end

end
