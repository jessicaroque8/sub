class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :image, :email, :staff_id_mb
  
  has_many :groups
  has_many :sub_requests
  has_many :sendees
end
