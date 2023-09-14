class AddLabelingRefToTasks < ActiveRecord::Migration[6.1]
  def change
    add_reference :tasks, :labeling, null: false, foreign_key: true
  end
end
