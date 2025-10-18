class ChangeDefaultOfAnshinPriceInSettings < ActiveRecord::Migration[8.0]
  def change
    change_column_default :settings, :anshin_price, from: 0, to: nil
  end
end
