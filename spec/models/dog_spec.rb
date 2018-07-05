require 'rails_helper'

RSpec.describe Dog, :type => :model do
  #sets variables using ModelHelper module
  before(:each) do
    set_variables
  end

  it 'has attributes for name, breed, age, city, bio, owner_id, user_rating' do
    expect(@bandit).to be_valid
  end

  it 'does not validate without a name' do
    bad_dog = Dog.create(breed: "Terrier", city: "Columbus, Ohio", owner_id: 4)
    expect(bad_dog).to be_invalid
  end

  it 'does not validate without an owner_id' do
    no_owner = Dog.create(name: "Blue", breed: "Border Collie", city: "Lore City, Ohio", user_rating: 4.0)
    expect(no_owner).to be_invalid
  end

  it 'has an attribute user_rating that defaults to 5' do
    expect(@whitefang.user_rating).to eq(5.00)
  end

  it 'has many users through pettings' do
    expect(@bandit.pettings.size).to eq(2)
    expect(@bandit.users).to include(@linda)
  end

  it 'has an #owner method that returns an instance of the User class' do
    expect(@bandit.owner.full_name).to eq("Johnny Quest")
  end

  it 'has a method to calculate the update its user_rating after a petting' do
    @whitefang.update_rating(@jquest_whitefang.pet_rating)

    expect(@whitefang.user_rating).to eq(3.50)
  end
end
