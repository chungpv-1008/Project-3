class CreateVideos < ActiveRecord::Migration[6.0]
  def change
    create_table :videos do |t|
      t.text :title
      t.text :description
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
    add_index :videos, [:course_id, :created_at]
  end
end
