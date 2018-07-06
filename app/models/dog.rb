class Dog < ActiveRecord::Base
  has_many :pettings
  has_many :users, through: :pettings #random people relationship
  has_one :pet_account

  validates :name, presence: true
  
  def owner
    User.find(self.pet_account.user_id)
  end

  def update_rating(new_rating)
    self.user_rating = ((new_rating + self.user_rating) / 2.0).round(2)
    self.save
  end

end
