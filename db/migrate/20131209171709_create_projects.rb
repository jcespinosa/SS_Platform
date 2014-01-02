class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :project_hash
      t.integer :user_id
      t.text :description
      t.string :status
      t.integer :progress

      t.timestamps
    end
    add_index :projects, [:user_id, :created_at]
  end
end
