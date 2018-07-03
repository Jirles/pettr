class Petting < ActiveRecord::Base
  belongs_to :user
  belongs_to :dog, optional: true

  def set_attributes_if_dog_exists
    if self.dog_id.blank?
      self.dog_id = nil
    else
      dog = Dog.find(self.dog_id)
      self.name = dog.name
      self.breed = dog.breed
    end
  end
end
