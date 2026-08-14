class LostAndFoundItem < ApplicationRecord
  belongs_to :reported_by_user, class_name: "User", foreign_key: "reported_by_user_id"
  belongs_to :found_by_user, class_name: "User", foreign_key: "found_by_user_id", optional: true

  # Sanitize inputs before validation
  before_validation :sanitize_inputs

  validates :title, presence: true, length: { minimum: 3, maximum: 255 }
  validates :description, presence: true, length: { minimum: 10, maximum: 5000 }
  validates :location, presence: true, length: { minimum: 3, maximum: 255 }
  validates :reported_by_user_id, presence: true, numericality: { only_integer: true }
  validates :found_by_user_id, numericality: { only_integer: true }, allow_nil: true
  validates :status, inclusion: { in: %w(found unfound) }

  scope :unfound, -> { where(status: "unfound") }
  scope :found, -> { where(status: "found") }
  scope :reported_by, ->(user) { where(reported_by_user_id: user.id) }

  def found?
    status == "found"
  end

  def unfound?
    status == "unfound"
  end

  private

  def sanitize_inputs
    self.title = title.to_s.strip if title.present?
    self.description = description.to_s.strip if description.present?
    self.location = location.to_s.strip if location.present?
  end
end
