class Label < ApplicationRecord
  has_many :labeling, dependent: :destroy
  has_many :relation_tasks, through: :labeling, source: :task
end
