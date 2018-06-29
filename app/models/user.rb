class User < ActiveRecord::Base
  has_secure_password 
  has_many :pettings
  has_many :dogs, through: :pettings #user can pet a lot of dogs

  validates :username, uniqueness: true, presence: true
  validates :email, presence: true

  def full_name
    self.first_name + " " + self.last_name
  end
end
