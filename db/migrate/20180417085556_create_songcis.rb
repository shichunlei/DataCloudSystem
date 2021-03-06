class CreateSongcis < ActiveRecord::Migration[5.0]
  def change
    create_table :songcis do |t|
      t.string :name, default:""
      t.string :author, default:""
      t.string :mtype, default:""
      t.text :content, default:""
      t.text :explanation, default:""
      t.text :appreciation, default:""

      t.timestamps
    end
  end
end
