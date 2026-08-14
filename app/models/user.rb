class User < ApplicationRecord
  has_secure_password

  has_many :reported_lost_and_found_items, class_name: "LostAndFoundItem", foreign_key: "reported_by_user_id", dependent: :destroy
  has_many :found_lost_and_found_items, class_name: "LostAndFoundItem", foreign_key: "found_by_user_id", dependent: :nullify

  validates :username, presence: true
end
