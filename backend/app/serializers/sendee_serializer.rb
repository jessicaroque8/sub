class SendeeSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :image, :reply, :user, :selected_sub

  belongs_to :user
  belongs_to :sub_request
  has_one :reply
  has_one :selected_sub

  def user
     object.user
  end

  def first_name
     object.user['first_name']
  end

  def last_name
     object.user['last_name']
  end

  def image
     object.user['image']
  end

  def reply
    object.reply
  end

end
