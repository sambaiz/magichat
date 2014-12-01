class CreateUserLogs < ActiveRecord::Migration
  def change
    create_table :user_logs do |t|
      t.integer :user_id
      t.integer :post_id

      t.timestamps
    end
    add_index :user_logs, [:user_id, :post_id], :unique => true
  end
end
