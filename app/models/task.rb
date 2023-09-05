class Task < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true, length: { maximum: 255}

  scope :latest, -> {order(created_at: :desc)}
  scope :sort_expired, -> {order(expired_at: :desc)}
  scope :n_search, -> (name_param){Task.where("name LIKE?", "%#{name_param}%")}
  scope :s_search, -> (status_param){Task.where(status: (status_param))}

  enum status:{
    not_started: 0, #未着手
    started: 1, #着手中
    completed: 2, #完了
  }
end