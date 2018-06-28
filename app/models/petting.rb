class Petting < ActiveRecord::Base
  belongs_to :user
  belongs_to :dog

  validates :name, presence: true unless :dog_id NOT NULL #not sure this will work
end
