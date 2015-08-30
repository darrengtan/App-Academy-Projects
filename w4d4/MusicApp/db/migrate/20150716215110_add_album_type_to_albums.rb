class AddAlbumTypeToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :album_type, :string
    change_column :albums, :album_type, :string, null: false
  end
end
