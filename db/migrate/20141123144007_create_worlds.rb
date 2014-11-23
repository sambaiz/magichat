class CreateWorlds < ActiveRecord::Migration
  def change
    create_table :worlds do |t|
      t.string :code, null: false
      t.boolean :the_end, default: false

      t.timestamps
    end
    add_index :worlds, :code, :unique => true
  end
end
