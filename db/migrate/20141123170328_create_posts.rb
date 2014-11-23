class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :text, null: false
      t.integer :user_id, null: false
      t.integer :world_id, null: false
      t.integer :point_x, null: false
      t.integer :point_y, null: false
      t.integer :point_z, null: false

      t.timestamps
    end
    add_index :posts, :user_id
    add_index :posts, :world_id
  end
end
