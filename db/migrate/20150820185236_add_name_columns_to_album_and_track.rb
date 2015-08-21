class AddNameColumnsToAlbumAndTrack < ActiveRecord::Migration
  def change
    add_column :albums, :title, :string
    add_column :tracks, :song, :string
  end
end
