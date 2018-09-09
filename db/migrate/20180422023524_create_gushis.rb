class CreateGushis < ActiveRecord::Migration[5.0]
  def change
    create_table :gushis do |t|
      t.string :name, default:""
      t.string :author, default:""
      t.string :mtype, default:""
      t.text :content, default:""
      t.text :translation, default:""
      t.text :explanation, default:""
      t.text :appreciation, default:""
      t.string :dynasty, default:""
      t.string :sid, default:""
      t.string :tags, default:""

      t.timestamps
    end
  end
end
