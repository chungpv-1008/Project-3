# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :encrypted_password, null: false
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at

      t.timestamps
    end

    add_column :users, :name, :string
    add_column :users, :remember_digest, :string
    add_column :users, :role, :integer, default: 0
    add_index :users, :email, unique: true
    add_index :users, :reset_password_token, unique: true
  end
end
