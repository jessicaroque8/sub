class ReplySerializer < ActiveModel::Serializer
  attributes :id, :note, :value, :updated_at

  belongs_to :sendee
  belongs_to :sub_request_id
end
