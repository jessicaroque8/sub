class SelectedSubSerializer < ActiveModel::Serializer
  attributes :id, :confirmed, :first_name, :last_name, :updated_at, :created_at

  belongs_to :sub_request
  belongs_to :sendee

  def first_name
     object.sendee.user.first_name
  end

  def last_name
     object.sendee.user.last_name
  end
end
