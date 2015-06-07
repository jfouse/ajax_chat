class RemoveHashKeyFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :hash_key, :string
  end
end
