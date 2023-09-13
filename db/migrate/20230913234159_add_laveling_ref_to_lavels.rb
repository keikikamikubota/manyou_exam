class AddLavelingRefToLavels < ActiveRecord::Migration[6.1]
  def change
    add_reference :lavels, :laveling, null: false, foreign_key: true
  end
end
