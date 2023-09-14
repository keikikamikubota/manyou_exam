class CreateLabelings < ActiveRecord::Migration[6.1]
  def change
    create_table :labelings do |t|
      t.integer :task_id
      t.integer :label_id

      t.timestamps
    end
  end
end
