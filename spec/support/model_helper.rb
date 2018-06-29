module ModelHelper

  def models_before_block
    before do
      let(:jquest) {
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
            :owner_id => jquest.id,
            :user_rating => 4.5
          )
      }

      let(:whitefang) {
        Dog.create(
          :name => "White Fang",
          :breed => "Siberian Husky",
          :age => 2,
          :city => "Juneau, Alaska",
          :bio => "Enjoys the call of the wild"
        )
      }

      let(:lightning) {
        User.create(
          :first_name => "Lightning",
          :last_name => "McQueen",
          :username => "VroomVroom",
          :email => "go_fast@cars.com",
          :password => 'fastest'
        )
      }

      let(:linda) {
        User.create(
          :first_name => "Linda",
          :last_name => "Belcher",
          :username => "Momma Belcher",
          :email => "lbelcher@bobsburgers.com",
          :password => 'bestmomever'
        )
      }

      let(:lightning_bandit) {
        Petting.create(
        :user_id => lightning.id,
        :dog_id => bandit.id,
        :name => "Bandit",
        :breed => "Bulldog",
        :location => "Raleigh, North Carolina",
        :pet_rating => 4.5,
        :description => 'Very happy, but very high energy, overall a good dog'
        )
      }

      let(:linda_bandit) {
        Petting.create(
        :user_id => linda.id,
        :dog_id => bandit.id,
        :name => "Bandit",
        :breed => "Bulldog",
        :location => "Ocean City, New Jersey",
        :pet_rating => 5,
        :description => 'BEST DOG EVAAA!!!!'
        )
      }
    end
  end
end
