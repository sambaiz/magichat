class AddTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :token, :string, null: false, default: ""
  end
end
