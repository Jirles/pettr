module ModelHelper

  def set_variables
    @jquest = User.create(
        :first_name => "Johnny",
        :last_name => "Quest",
        :username => "Mr.Quest",
        :email => "jquest@cartoons.com",
        :password => 'password'
      )

    @bandit = Dog.create(
          :name => "Bandit",
          :breed => 'Bulldog',
          :age => 4,
          :city => 'Durham, North Carolina',
          :bio => "Likes adventures, bones, and naps",
          :owner_id => @jquest.id,
          :user_rating => 4.5
        )

    @whitefang = Dog.create(
        :name => "White Fang",
        :breed => "Siberian Husky",
        :age => 2,
        :city => "Juneau, Alaska",
        :bio => "Enjoys the call of the wild"
      )

    @lightning = User.create(
        :first_name => "Lightning",
        :last_name => "McQueen",
        :username => "VroomVroom",
        :email => "go_fast@cars.com",
        :password => 'fastest'
      )

    @linda = User.create(
        :first_name => "Linda",
        :last_name => "Belcher",
        :username => "Momma Belcher",
        :email => "lbelcher@bobsburgers.com",
        :password => 'bestmomever'
      )

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

    @jquest_whitefang = Petting.create(
        :user_id => @jquest.id,
        :dog_id => @whitefang.id,
        :location => "Yukon",
        :pet_rating => 2,
        :description => "Seemed a little wild..."
      )
  end

end
