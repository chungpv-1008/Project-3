class CreateImages < ActiveRecord::Migration[6.0]
  def change
    create_table :images do |t|
      t.string :name
      t.integer :status_assign, default: 0
      t.integer :status_stick, default: 0
      t.references :user, null: false, foreign_key: true
      t.references :project, foreign_key: true
    end
  end
end
