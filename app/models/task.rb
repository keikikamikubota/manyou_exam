class Task < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true, length: { maximum: 255}

  belongs_to :user

  scope :latest, -> {order(created_at: :desc)}
  scope :sort_expired, -> {order(expired_at: :desc)}
  scope :sort_priority, -> {order(priority: :asc)}
  scope :n_search, -> (name_param){ where("name LIKE?", "%#{name_param}%") }
  scope :s_search, -> (status_param){ where(status: (status_param)) }
  scope :both_search, -> (name_param, status_param){ where("name LIKE?", "%#{name_param}%").where(status: (status_param)) }

  enum status:{ 未着手: 0, 着手中: 1, 完了: 2 }
  enum priority:{ 高: 0, 中: 1, 低: 2 }
end