class Petting < ActiveRecord::Base
  belongs_to :user
  belongs_to :dog, optional: true
  validate :dog_id_or_name_present?

  def set_attributes_if_dog_exists
    if self.dog_id.blank?
      self.dog_id = nil
    else
      dog = Dog.find(self.dog_id)
      self.name = dog.name
      self.breed = dog.breed
    end
  end

  def dog_id_or_name_present?
    if name.blank? && dog_id.blank?
      errors.add(:pettr_profile_and_name, "fields can't both be blank.")
    end
  end

  def self.most_recent
    order(updated_at: :desc, created_at: :desc)
  end

end
