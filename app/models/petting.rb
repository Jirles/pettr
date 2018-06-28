class Petting < ActiveRecord::Base
  belongs_to :user
  belongs_to :dog

  validates :name, presence: true #will assign name in controller if only dog_id is passed 
end
