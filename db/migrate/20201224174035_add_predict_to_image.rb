class AddPredictToImage < ActiveRecord::Migration[6.0]
  def change
    add_column :images, :predict, :integer, default: 0
  end
end
