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

  it 'does not validate if the bio is over 500 chars' do
    long_winded = Dog.create(name: "Fido", breed: "Bull Terrier", age: 1.5, city: "Hollywood, CA", bio: "Doggo ipsum adorable doggo maximum borkdrive. Boof very hand that feed shibe vvv lotsa pats, blop shoober. Wow such tempt doing me a frighten I am bekom fat extremely cuuuuuute wow very biscit ur givin me a spook, puggo porgo snoot. Heckin shoober waggy wags h*ck very taste wow waggy wags borking doggo, smol woofer h*ck fat boi woofer, dat tungg tho pats doing me a frighten ur givin me a spook most angery pupper I have ever seen. Lotsa pats tungg doggo long water shoob, smol borking doggo with a long snoot for pats pats. Clouds borking doggo doing me a frighten maximum borkdrive adorable doggo, super chub very good spot thicc puggo, he made many woofs borking doggo heckin good boys.") #=> 692 characters

    expect(long_winded).to be_invalid
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
