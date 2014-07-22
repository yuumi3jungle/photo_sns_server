class AddUserIdToPost < ActiveRecord::Migration
  def change
    add_reference :posts, :user, index: true
    remove_column :posts, :name
  end
end
