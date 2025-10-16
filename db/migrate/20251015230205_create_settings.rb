class CreateSettings < ActiveRecord::Migration[7.1]
  def change
    create_table :settings do |t|
      t.string :name, null: false
      t.integer :price, null: false
      t.string :pos_numbers, null: false

      t.timestamps
    end
  end
end
