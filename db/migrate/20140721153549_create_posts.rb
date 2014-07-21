class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :name
      t.string :photo
      t.text :caption

      t.timestamps
    end
  end
end
