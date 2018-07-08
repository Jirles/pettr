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

  def has_pets?
    !!self.pet_accounts
  end

  def pets
    self.pet_accounts.collect{ |account| Dog.find(account.dog_id) }
  end

  def self.find_by_or_create_from_auth_hash(auth_hash)
    return if auth['info']['email'].nil?

    user = User.find_by(email: auth_hash['info']['email'])
    if user.nil?
      user = User.create(first_name: first_name_from_auth(auth_hash), last_name: last_name_by_auth(auth_hash), email: auth_hash['info']['email'], password: auth_hash['info']['uid'])
    end
    user
  end

  private

  def first_name_from_auth(auth)
    auth['info']['name'].split(" ")[0]
  end

  def last_name_by_auth(auth)
    auth['info']['name'].split(" ")[-1]
  end
  
end
