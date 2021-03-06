class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :omniauthable
          # :confirmable,
  include DeviseTokenAuth::Concerns::User

  has_and_belongs_to_many :groups, :unique => true
  has_many :sendees
  has_many :sub_requests, through: :sendees
  has_many :replies, through: :sendees

  validates_presence_of :first_name, :last_name, :email
  validates_uniqueness_of :staff_id_mb

  before_validation :set_provider

  private

      def set_provider
        self.provider = "email"
      end


end
