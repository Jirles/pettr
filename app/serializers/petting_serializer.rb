class PettingSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :dog_id, :name, :breed, :location, :pet_rating, :description, :created_at
  has_many :comments
end
