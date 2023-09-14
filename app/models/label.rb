class Label < ApplicationRecord
  has_many :labeling, dependent: :destroy
  has_many :tasks, through: :labeling, source: :task
end
