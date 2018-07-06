require 'rails_helper'

describe 'Petting Model' do
  before(:each) do
    set_variables
  end

  it 'has attributes user_id, dog_id, name, breed, location, pet_rating, and description' do
    expect(@linda_bandit).to be_valid
  end

  it 'must have a user_id' do
    bad_pet = Petting.create(:dog_id => @buck.id, :pet_rating => 4.5, :location => "Fullsteam Brewery")
    expect(bad_pet).to be_invalid
  end

end
