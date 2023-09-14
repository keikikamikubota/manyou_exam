class AddLabelingRefToLabels < ActiveRecord::Migration[6.1]
  def change
    add_reference :labels, :labeling, null: false, foreign_key: true
  end
end
