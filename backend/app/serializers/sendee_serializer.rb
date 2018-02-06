class SendeeSerializer < ActiveModel::Serializer
  attributes :id, :sub, :created_at, :updated_at, :confirmed,
   :first_name, :last_name, :image, :reply

  belongs_to :user
  belongs_to :sub_request
  has_one :reply

  def first_name
     object.user.first_name
  end

  def last_name
     object.user.last_name
  end

  def image
     object.user.image
  end

  def reply
    object.reply
  end

end
