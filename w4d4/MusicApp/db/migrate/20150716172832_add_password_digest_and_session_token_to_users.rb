class AddPasswordDigestAndSessionTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :password_digest, :string
    change_column :users, :password_digest, :string, null: false
    add_column :users, :session_token, :string
    change_column :users, :session_token, :string, null: false
  end
end
