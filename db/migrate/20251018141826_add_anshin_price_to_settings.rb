class AddAnshinPriceToSettings < ActiveRecord::Migration[8.0]
  def change
    add_column :settings, :anshin_price, :integer, null: false, default: 0
  end
end
