class AddAttachmentToUsers < ActiveRecord::Migration
  def change
    add_attachment :users, :attachment
  end
end
