class Group < ApplicationRecord
   has_and_belongs_to_many :users, :unique => true
   validates_presence_of :name
end
