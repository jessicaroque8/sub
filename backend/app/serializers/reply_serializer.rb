class ReplySerializer < ActiveModel::Serializer
  attributes :id, :note, :value, :created_at, :updated_at

  belongs_to :sendee
  belongs_to :sub_request_id
end
