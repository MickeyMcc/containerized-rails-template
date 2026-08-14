class LostAndFoundItem < ApplicationRecord
  belongs_to :reported_by_user, class_name: "User", foreign_key: "reported_by_user_id"
  belongs_to :found_by_user, class_name: "User", foreign_key: "found_by_user_id", optional: true

  validates :title, presence: true
  validates :description, presence: true
  validates :location, presence: true
  validates :reported_by_user_id, presence: true
  validates :status, inclusion: { in: %w(found unfound) }

  scope :unfound, -> { where(status: "unfound") }
  scope :found, -> { where(status: "found") }
  scope :reported_by, ->(user) { where(reported_by_user_id: user.id) }
end
