require 'rails_helper'

RSpec.describe 'Dog Features', :type => :feature do
  before do
    set_variables
  end

  it 'has an index page' do
    visit dogs_path
    expect(page.status).to eq(200)
  end

  it 'has a list of links to a dog profiles' do
    visit dogs_path

    expect(page).to have_link("Bandit")
    expect(page).to have_content("Bulldog")
    expect(page).to have_content("Durham, North Carolina")
    expect(page).to have_content("4.5 stars")
  end
  # dogs index & show => public - dogs index should have link in navbar
    # dogs index also has a filter option for results ordering => recently update, highest rating
    # maybe even a search feature?
  # dogs new, edit, update, create, destroy all namespaced under owner
    # can be linked to from user profile page
    # or the navbar if a dog exists

end
