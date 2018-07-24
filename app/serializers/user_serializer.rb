class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name
  has_many :pet_accounts
  has_many :pettings
end
