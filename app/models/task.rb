class Task < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true, length: { maximum: 255}

  scope :latest, -> {order(created_at: :desc)}
  scope :sort_expired, -> {order(expired_at: :desc)}
end
