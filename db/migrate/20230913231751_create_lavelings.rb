class CreateLavelings < ActiveRecord::Migration[6.1]
  def change
    create_table :lavelings do |t|
      t.integer :task_id
      t.integer :lavel_id

      t.timestamps
    end
  end
end
