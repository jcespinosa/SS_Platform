class AddProfileFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :about, :text
    add_column :users, :degree, :string
    add_column :users, :job, :string
    add_column :users, :workplace, :string
    add_column :users, :speciality, :string
  end
end
