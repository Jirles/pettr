class DogSerializer < ActiveModel::Serializer
  attributes :id, :name, :breed, :age, :city, :user_rating, :bio
  has_many :pettings
end
