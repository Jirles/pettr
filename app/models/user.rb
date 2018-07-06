class User < ActiveRecord::Base
  has_secure_password
  has_many :pettings
  has_many :dogs, through: :pettings #user can pet a lot of dogs
  has_many :pet_accounts

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  def full_name
    self.first_name + " " + self.last_name
  end

  def pets
    self.pet_accounts.collect{ |account| Dog.find(account.dog_id) }
  end
end
