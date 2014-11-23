class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.integer :hp, null: false
      t.integer :mp, null: false
      t.integer :world_id, null: false
      t.integer :point_x, null: false
      t.integer :point_y, null: false
      t.integer :point_z, null: false

      t.timestamps
    end
    add_index :users, :name, :unique => true
    add_index :users, :world_id, :unique => true
  end
end
