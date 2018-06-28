class User < ActiveRecord::Base
  has_many :dogs # owner-pet relationship
  has_many :pettings
  has_many :dogs, through: :pettings #user can pet a lot of dogs

  validates :username, uniqueness: true, presence: true
  validates :email, presence: true 
end
