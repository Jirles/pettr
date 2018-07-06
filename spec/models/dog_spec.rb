require 'rails_helper'

RSpec.describe Dog, :type => :model do
  #sets variables using ModelHelper module
  before(:each) do
    set_variables
  end

  it 'has attributes for name, breed, age, city, bio, user_rating' do
    expect(@bandit).to be_valid
  end

  it 'does not validate without a name' do
    bad_dog = Dog.create(breed: "Terrier", city: "Columbus, Ohio")
    expect(bad_dog).to be_invalid
  end

  it 'has an attribute user_rating that defaults to 5' do
    expect(@buck.user_rating).to eq(5.00)
  end

  it 'has many users through pettings' do
    expect(@bandit.pettings.size).to eq(2)
    expect(@bandit.users).to include(@linda)
  end

  it 'has an #owner method that returns an instance of the User class' do
    expect(@bandit.owner.full_name).to eq("Johnny Quest")
  end

  it 'has a method to calculate the update its user_rating after a petting' do
    @buck.update_rating(@jquest_buck.pet_rating)

    expect(@buck.user_rating).to eq(3.50)
  end
end
