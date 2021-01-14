class AddBase64ToImages < ActiveRecord::Migration[6.0]
  def change
    add_column :images, :base_64, :text
  end
end
