class Dog < ActiveRecord::Base
  belongs_to :user #owner relationship
  has_many :pettings
  has_many :users, through: :pettings #random people relationship
  
  validates :name, presence: true
end
