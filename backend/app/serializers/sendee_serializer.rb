class SendeeSerializer < ActiveModel::Serializer
  attributes :id, :sub, :confirmed, :first_name, :last_name, :image, :reply, :user

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

  def user
     object.user
  end

end
