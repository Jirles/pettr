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

      it 'can be accessed directly from a users profile' do
        visit user_path(@jquest)
        click_link "Bandit"

        expect(page.current_path).to eq(owner_dog_path(@bandit))
      end

      it 'has links to edit and delete the dogs profile' do
        visit owner_dog_path(@bandit)

        expect(page).to have_link("Edit Bandit's Profile")
        expect(page).to have_link("Delete Bandit's Profile")
      end
    end
  end
  describe 'owner dog new page' do
    before do
      visit login_path
      fill_in(:session_email, with: "jmiller@london.com")
      fill_in(:session_password, with: 'password')
      click_button "LogIn"
    end

    it 'can be accessed from a users profile page' do
      visit user_path(@judge)
      click_link "Create a Pettr Pet Profile"

      expect(page.current_path).to eq(new_owner_dog_path)
    end

    it 'creates a new dog and a new pet account' do
      visit new_owner_dog_path
      fill_in(:dog_name, with: "Spot")
      fill_in(:dog_breed, with: "Mutt")
      fill_in(:dog_age, with: 2)
      fill_in(:dog_city, with: "Winston Salem, NC")
      fill_in(:dog_bio, with: "Spot may be the runt of the litter but he's big on heart!")
      click_button "Create Profile"

      expect(Dog.last.name).to eq("Spot")
      expect(PetAccount.all.size).to eq(3)
    end

    it 'will raise an error if a name is not present' do
      visit new_owner_dog_path
      fill_in(:dog_breed, with: "Mutt")
      fill_in(:dog_age, with: 2)
      fill_in(:dog_city, with: "Winston Salem, NC")
      fill_in(:dog_bio, with: "Spot may be the runt of the litter but he's big on heart!")
      click_button "Create Profile"

      expect(page).to have_content("Name can't be blank")
      expect(page).to have_selector("form")
    end

    it "will raise an error if a bio is too long" do
      visit new_owner_dog_path
      fill_in(:dog_breed, with: "Mutt")
      fill_in(:dog_age, with: 2)
      fill_in(:dog_city, with: "Winston Salem, NC")
      fill_in(:dog_bio, with: "Doggo ipsum adorable doggo maximum borkdrive. Boof very hand that feed shibe vvv lotsa pats, blop shoober. Wow such tempt doing me a frighten I am bekom fat extremely cuuuuuute wow very biscit ur givin me a spook, puggo porgo snoot. Heckin shoober waggy wags h*ck very taste wow waggy wags borking doggo, smol woofer h*ck fat boi woofer, dat tungg tho pats doing me a frighten ur givin me a spook most angery pupper I have ever seen. Lotsa pats tungg doggo long water shoob, smol borking doggo with a long snoot for pats pats. Clouds borking doggo doing me a frighten maximum borkdrive adorable doggo, super chub very good spot thicc puggo, he made many woofs borking doggo heckin good boys.")
      click_button "Create Profile"

      expect(page).to have_content("500 characters is the maximum allowed for a bio")
      expect(page).to have_selector("form")
    end

    describe 'owner dog edit page' do
      before do
        visit login_path
        fill_in(:session_email, with: "jmiller@london.com")
        fill_in(:session_password, with: 'password')
        click_button "LogIn"
        visit edit_owner_dog_path(@buck)
      end

      it 'has a form with prefilled information' do
        expect(page).to have_selector('form')
        expect(page).to have_css('input[value="Buck"]')
        expect(page).to have_css('#dog_bio', text: "Enjoys the call of the wild")
      end

      it 'can only be accessed by the owner' do
        visit edit_owner_dog_path(@bandit)
        expect(page).to have_content("Sorry, but you do not have access to that page.")
        expect(page.current_path).to eq(dogs_path)
      end

      it 'lets you edit a dogs profile' do
        fill_in(:dog_name, with: "Ghost Dog of the Northland")
        fill_in(:dog_city, with: "Klondike Region, Canada")
        click_button "Edit Profile"

        expect(page).to have_content("Profile successfully updated!")
        expect(page.current_path).to eq(owner_dog_path(@buck))
        expect(Dog.find(@buck.id).name).to eq("Ghost Dog of the Northland")
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
