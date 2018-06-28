require 'rails_helper'

RSpec.describe Dog, :type => :model do
  let(:owner) {
    User.create(
      :first_name => "Johnny",
      :last_name => "Quest",
      :username => "Mr.Quest",
      :email => "jquest@cartoons.com",
      :password => 'password'
    )
  }

  let(:bandit) {
    Dog.create(
        :name => "Bandit",
        :breed => 'Bulldog',
        :age => 4,
        :city => 'Durham, North Carolina',
        :bio => "Likes adventures, bones, and naps",
        :owner_id => owner.id,
        :user_rating => 4.5,
        :instagram => 'http://instagram.com/fido_page'
      )
  }

  let(:whitefang) {
    Dog.create(
      :name => "White Fang",
      :breed => "Siberian Husky",
      :age => 2,
      :city => "Juneau, Alaska",
      :bio => "Enjoys the call of the wild",
      :instagram => 'http://instagram.com/white_fang'
    )
  }

  let(:user_1) {
    User.create(
      :first_name => "Lightning",
      :last_name => "McQueen",
      :username => "VroomVroom",
      :email => "go_fast@cars.com",
      :password => 'fastest'
    )
  }

  let(:user_2) {
    User.create(
      :first_name => "Linda",
      :last_name => "Belcher",
      :username => "Momma Belcher",
      :email => "lbelcher@bobsburgers.com",
      :password => 'bestmomever'
    )
  }

  let(:petting_1) {
    Petting.create(
    :user_id => user_1.id,
    :dog_id => bandit.id,
    :name => "Bandit",
    :breed => "Bulldog",
    :location => "Raleigh, North Carolina",
    :pet_rating => 4.5,
    :description => 'Very happy, but very high energy, overall a good dog'
  )
  }

  let(:petting_2) {
    Petting.create(
    :user_id => user_2.id,
    :dog_id => bandit.id,
    :name => "Bandit",
    :breed => "Bulldog",
    :location => "Hoboken, New Jersey",
    :pet_rating => 5,
    :description => 'BEST DOG EVAAAA!!!!!'
  )
  }

  it 'has attributes for name, breed, age, city, bio, owner_id, user_rating, instagram' do
    expect(bandit).to be_valid
  end

  it 'has an attribute user_rating that defaults to 5' do
    expect(whitefang.user_rating).to eq(5)
  end

  it 'has many users through pettings' do
    expect(bandit.users.size).to eq(2)
    expect(bandit.users).to include(user_2)
  end

  it 'has an #owner method that returns an instance of the User class' do
    expect(bandit.owner.full_name).to eq("Johny Quest")
  end
end
