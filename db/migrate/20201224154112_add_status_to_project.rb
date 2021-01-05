class AddStatusToProject < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :statas, :integer, default: 0
  end
end
