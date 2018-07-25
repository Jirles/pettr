class PettingSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :dog_id, :name, :breed, :location, :pet_rating, :description, :created_at
  has_many :comments
  has_one :user 
    class UserSerializer < ActiveModel::Serializer
      attributes :id, :first_name, :last_name
    end 
end
