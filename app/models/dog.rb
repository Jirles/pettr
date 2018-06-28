class Dog < ActiveRecord::Base
  has_many :pettings
  has_many :users, through: :pettings #random people relationship

  validates :name, presence: true

  def owner
    self.owner_id ? User.find(self.owner_id) : nil
  end

end
