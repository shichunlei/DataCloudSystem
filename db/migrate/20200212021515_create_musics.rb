class CreateMusics < ActiveRecord::Migration[5.0]
  def change
    create_table :musics, :id => false do |t|
      t.string :id
      t.string :name, default:""
      t.string :audio_url, default:""
      t.string :artists, default:""
      t.string :album_url, default:""
      t.text :lyric, default:""

      t.timestamps
    end
  end
end
