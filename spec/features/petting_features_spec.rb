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
      click_link "LogOut"

      visit new_petting_path
      expect(page.current_path).to eq(login_path)
    end

    it 'has a form with petting fields' do
      visit new_petting_path

      expect(page).to have_selector('form')
      expect(page).to have_content("Select a dog's Pettr profile:")
      expect(page).to have_field(:petting_pet_rating_00) #=> value is a float, so this means 0.0
      expect(page).to have_field(:petting_dog_id)
      expect(page).to have_button("Pettr")
    end

    it 'creates a new petting instance using a dogs profile and redirects the user to the petting show page' do
      visit new_petting_path
      select("Buck", from: :petting_dog_id)
      fill_in(:petting_location, with: "Bob's Burgers Restaurant")
      choose(:petting_pet_rating_30) #=> 3.0
      fill_in(:petting_description, with: "Not sure where this dog came from, but Louise liked it.")
      click_button "Pettr"

      expect(page.current_path).to eq(petting_path(Petting.last))
      expect(page).to have_content("Breed: Siberian Husky")
      expect(page).to have_content("3.0/5.0 would do it again")
      expect(Petting.last.description).to eq("Not sure where this dog came from, but Louise liked it.")
    end

    it 'creates a new petting instance even if a dog_id is not chosen' do
      visit new_petting_path
      fill_in(:petting_name, with: "Blue")
      fill_in(:petting_breed, with: "Border Collie")
      fill_in(:petting_location, with: "Lore City, Ohio")
      choose(:petting_pet_rating_50) #=> 5.0
      fill_in(:petting_description, with: "Best Dawg Ever.")
      click_button "Pettr"

      expect(page.current_path).to eq(petting_path(Petting.last))
      expect(page).to have_content("Breed: Border Collie")
    end

    it 'defaults to the linked profile data if a dog_id, name, and breed are all submitted' do
      visit new_petting_path
      select("Bandit", from: :petting_dog_id)
      fill_in(:petting_name, with: "Blue")
      fill_in(:petting_breed, with: "Border Collie")
      fill_in(:petting_location, with: "Lore City, Ohio")
      choose(:petting_pet_rating_50) #=> 5.0
      fill_in(:petting_description, with: "Best Dawg Ever.")
      click_button "Pettr"

      expect(page).to have_content("Dog: Bandit")
      expect(page).to have_content("Breed: Bulldog")
    end
  end

  context 'edit page' do
    before do
      @louise = create_louise_belcher
      login_as_louise
      @louise_blue = Petting.create(user_id: @louise.id, name: "Blue", breed: "Border Collie", location: "Lre City, Ohio", pet_rating: 4.0, description: "A very pretty pup")
    end

    it 'has a form with pre-filled information' do
      visit edit_petting_path(@louise_blue)

      expect(page).to have_selector('form')
      expect(page).to have_css('input[value="Blue"]')
      expect(page).to have_checked_field(:petting_pet_rating_40) #=> 4.0
      expect(page).to have_css('#petting_description', text: "A very pretty pup")
    end

    it 'can only be accessed by the user who owns the petting involved' do
      visit edit_petting_path(@linda_bandit)

      expect(page.current_path).to eq(root_path)
      #expect(page).to have_content("You don't have access to this item") or an error page
    end

    it 'lets you edit a petting' do
      visit edit_petting_path(@louise_blue)
      fill_in(:petting_location, with: "Lore City, Ohio")
      click_button "Pettr"

      expect(page.current_path).to eq(petting_path(@louise_blue))
      expect(page).to have_content("Location: Lore City, Ohio")
    end

    it 'can be accessed by an Edit button on the pettings show page' do
      visit petting_path(@louise_blue)
      click_link "Edit"
      expect(page.current_path).to eq(edit_petting_path(@louise_blue))
    end
  end

  context 'delete/destroy action features' do
    before do
      @louise = create_louise_belcher
      login_as_louise
      @louise_blue = Petting.create(user_id: @louise.id, name: "Blue", breed: "Border Collie", location: "Lore City, Ohio", pet_rating: 4.0, description: "A very pretty pup")
    end

    it 'can only be accessed by a pettings owner' do
      visit petting_path(@linda_bandit)
      expect(page).not_to have_button("Delete")
    end

    it 'deletes a petting' do
      visit petting_path(@louise_blue)
     click_link "Delete"

      expect(page.current_path).to eq(root_path)
      expect(Petting.find_by(id: @louise_blue.id)).to be_falsey
      end
  end
end
