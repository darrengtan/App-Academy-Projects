class AddIndicesToNotes < ActiveRecord::Migration
  def change
    add_index :notes, :user_id
    add_index :notes, :track_id
  end
end
