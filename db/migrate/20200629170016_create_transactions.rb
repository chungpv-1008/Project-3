class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.references :course, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
    end
    add_index :transactions, [:user_id, :course_id]
  end
end
