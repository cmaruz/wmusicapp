class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :title
      t.string :cover
      t.integer :user_id

      t.timestamps
    end
  end
end