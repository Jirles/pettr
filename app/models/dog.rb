class Dog < ActiveRecord::Base
  has_many :pettings
  has_many :users, through: :pettings #random people relationship

  validates :name, presence: true
  validates :owner_id, presence: true

  def owner
    User.find(self.owner_id)
  end

  def owner=(user)
    self.owner_id = user.id
  end

  def update_rating(new_rating)
    self.user_rating = ((new_rating + self.user_rating) / 2.0).round(2)
    self.save
  end

end
