class CreateUserProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :user_projects do |t|
      t.references :project, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
    end
  end
end
