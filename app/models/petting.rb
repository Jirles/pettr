class Petting < ActiveRecord::Base
  belongs_to :user
  belongs_to :dog

  validates :user_id, presence: true 
end
