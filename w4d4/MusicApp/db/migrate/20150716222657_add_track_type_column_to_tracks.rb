class AddTrackTypeColumnToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :track_type, :string
    change_column :tracks, :track_type, :string, null: false
  end
end
