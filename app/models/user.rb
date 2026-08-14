class User < ApplicationRecord
  has_secure_password

  has_many :reported_lost_and_found_items, class_name: "LostAndFoundItem", foreign_key: "reported_by_user_id", dependent: :destroy
  has_many :found_lost_and_found_items, class_name: "LostAndFoundItem", foreign_key: "found_by_user_id", dependent: :nullify

  # Sanitize inputs before validation
  before_validation :sanitize_inputs

  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 50 }, 
                        format: { with: /\A[a-zA-Z0-9_-]+\z/, message: "only allows letters, numbers, underscores and hyphens" }
  validates :password, presence: true, length: { minimum: 8, maximum: 128 }, if: :new_record?
  validates :password, length: { minimum: 8, maximum: 128 }, if: :password.present?, allow_nil: true

  private

  def sanitize_inputs
    self.username = username.to_s.strip.downcase if username.present?
  end
end
