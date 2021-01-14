class ChangeStatasFromProject < ActiveRecord::Migration[6.0]
  def change
    rename_column :projects, :statas, :status
  end
end
