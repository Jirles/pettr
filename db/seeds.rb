# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

jquest = User.create(
    :first_name => "Johnny",
    :last_name => "Quest",
    :email => "jquest@cartoons.com",
    :password => 'password'
  )

    lightning = User.create(
      :first_name => "Lightning",
      :last_name => "McQueen",
      :email => "go_fast@cars.com",
      :password => 'fastest'
    )

    linda = User.create(
      :first_name => "Linda",
      :last_name => "Belcher",
      :email => "lbelcher@bobsburgers.com",
      :password => 'bestmomever'
    )

    judge = User.create(
      :first_name => "Judge",
      :last_name => "Miller",
      :email => "jmiller@london.com",
      :password => "password"
    )

#dogs
    bandit = Dog.create(
      :name => "Bandit",
      :breed => 'Bulldog',
      :age => 4,
      :city => 'Durham, North Carolina',
      :bio => "Likes adventures, bones, and naps",
      :owner_id => jquest.id,
      :user_rating => 4.5
    )

  buck = Dog.create(
    :name => "Buck",
    :breed => "Siberian Husky",
    :age => 2,
    :city => "Juneau, Alaska",
    :owner_id => judge.id,
    :bio => "Enjoys the call of the wild"
  )

#pettings
lightning_bandit = Petting.create(
  :user_id => lightning.id,
  :dog_id => bandit.id,
  :name => "Bandit",
  :breed => "Bulldog",
  :location => "Raleigh, North Carolina",
  :pet_rating => 4.5,
  :description => 'Very happy, but very high energy, overall a good dog'
  )

linda_bandit = Petting.create(
  :user_id => linda.id,
  :dog_id => bandit.id,
  :name => "Bandit",
  :breed => "Bulldog",
  :location => "Ocean City, New Jersey",
  :pet_rating => 5,
  :description => 'BEST DOG EVAAA!!!!'
  )

linda_whitefang = Petting.create(
  :user_id => linda.id,
  :dog_id => buck.id,
  :location => "Ocean City, New Jersey",
  :pet_rating => 3,
  :description => 'Eh... it was ok'
  )

jquest_whitefang = Petting.create(
    :user_id => jquest.id,
    :dog_id => buck.id,
    :location => "Yukon",
    :pet_rating => 2,
    :description => "Seemed a little wild..."
  )
# dog doesn't have a profile
  jquest_scooby = Petting.create(
    :user_id => jquest.id,
    :name => "Scooby Doo",
    :breed => "Great Dane",
    :location => "The haunted house",
    :pet_rating => 4,
    :description => "Good dog, but awfully nervous for some reason"
  )
