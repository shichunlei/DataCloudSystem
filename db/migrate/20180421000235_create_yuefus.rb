class CreateYuefus < ActiveRecord::Migration[5.0]
  def change
    create_table :yuefus do |t|
      t.string :name, default:""
      t.string :chapter, default:""
      t.text :content, default:""
      t.text :commentary, default:""
      t.text :appreciation, default:""
      t.text :translation, default:""
      t.text :interpretation, default:""
      t.string :dynasty, default:""
      t.string :sid, default:""
      t.string :tags, default:""
      t.string :author, default:""
      t.text :background, default:""

      t.timestamps
    end
  end
end
