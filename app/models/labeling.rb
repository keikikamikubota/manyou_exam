class Labeling < ApplicationRecord
  has_many :tasks
  has_many :labels
end
