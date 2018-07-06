module VariableHelper

  def set_variables
    #users
    @jquest = User.create(
        :first_name => "Johnny",
        :last_name => "Quest",
        :email => "jquest@cartoons.com",
        :password => 'password'
      )

    @lightning = User.create(
      :first_name => "Lightning",
      :last_name => "McQueen",
      :email => "go_fast@cars.com",
      :password => 'fastest'
    )

    @linda = User.create(
      :first_name => "Linda",
      :last_name => "Belcher",
      :email => "lbelcher@bobsburgers.com",
      :password => 'bestmomever'
    )

    @judge = User.create(
      :first_name => "Judge",
      :last_name => "Miller",
      :email => "jmiller@london.com",
      :password => "password"
    )

    #dogs
    @bandit = Dog.create(
      :name => "Bandit",
      :breed => 'Bulldog',
      :age => 4,
      :city => 'Durham, North Carolina',
      :bio => "Likes adventures, bones, and naps",
      :user_rating => 4.5
    )

    @bandit_account = PetAccount.create(:user_id => @jquest.id, :dog_id => @bandit.id)

    @buck = Dog.create(
      :name => "Buck",
      :breed => "Siberian Husky",
      :age => 2,
      :city => "Juneau, Alaska",
      :bio => "Enjoys the call of the wild",
    )

    @buck_account = PetAccount.create(:user_id => @judge.id, :dog_id => @buck.id)

    #pettings
    @lightning_bandit = Petting.create(
      :user_id => @lightning.id,
      :dog_id => @bandit.id,
      :name => "Bandit",
      :breed => "Bulldog",
      :location => "Raleigh, North Carolina",
      :pet_rating => 4.5,
      :description => 'Very happy, but very high energy, overall a good dog'
      )

    @linda_bandit = Petting.create(
      :user_id => @linda.id,
      :dog_id => @bandit.id,
      :name => "Bandit",
      :breed => "Bulldog",
      :location => "Ocean City, New Jersey",
      :pet_rating => 5,
      :description => 'BEST DOG EVAAA!!!!'
      )

    @linda_buck = Petting.create(
      :user_id => @linda.id,
      :dog_id => @buck.id,
      :location => "Ocean City, New Jersey",
      :pet_rating => 3,
      :description => 'Eh... it was ok'
      )

    @jquest_buck = Petting.create(
        :user_id => @jquest.id,
        :dog_id => @buck.id,
        :location => "Yukon",
        :pet_rating => 2,
        :description => "Seemed a little wild..."
      )
  end

end
