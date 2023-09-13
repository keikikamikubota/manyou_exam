class CreateLavels < ActiveRecord::Migration[6.1]
  def change
    create_table :lavels do |t|
      t.string :name

      t.timestamps
    end
  end
end
