require 'rails_helper'

RSpec.describe 'Petting Features', :type => :feature do
  before do
    set_variables
  end

  context 'index page' do
    it 'shows all of the pettings as links to their individual show pages' do
      visit pettings_path

      expect(page).to have_content("Linda Belcher pet Bandit!")
      expect(page).to have_link("BEST DOG EVAAA!!!!")
      expect(page).to have_content("5/5 would do it again")
      expect(page).to have_content('Ocean City, New Jersey')
    end
  end

end
