require 'rails_helper'

RSpec.describe Dog, :type => :model do
  #sets before block
  models_before_block

  it 'has attributes for name, breed, age, city, bio, owner_id, user_rating' do
    expect(bandit).to be_valid
  end

  it 'does not validate without a name' do
    bad_dog = Dog.create(breed: "Terrier", city: "Columbus, Ohio")
    expect(bad_dog).to be_invalid
  end

  it 'has an attribute user_rating that defaults to 5' do
    expect(whitefang.user_rating).to eq(5)
  end

  it 'has many users through pettings' do
    expect(bandit.pettings.size).to eq(2)
    expect(bandit.users).to include(user_2)
  end

  it 'has an #owner method that returns an instance of the User class' do
    expect(bandit.owner.full_name).to eq("Johnny Quest")
  end
end
