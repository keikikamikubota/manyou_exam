class Task < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true, length: { maximum: 255}

  scope :latest, -> {order(created_at: :desc)}
  scope :sort_expired, -> {order(expired_at: :desc)}
  scope :n_search, -> (name_param){Task.where("name LIKE?", "%#{name_param}%")}
  scope :s_search, -> (status_param){Task.where(status: (status_param))}

  enum status:{
    未着手: 0, #not_startedから変換していたが、直接日本語表記に変更
    着手中: 1,
    完了: 2,
  }
end