class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :name, default:""
      t.attachment :image
      t.string :author, default:""
      t.string :dynasty, default:""
      t.string :chapter, default:""
      t.string :section, default:""
      t.text :content, default:""
      t.text :commentary, default:""
      t.text :translation, default:""
      t.text :appreciation, default:""
      t.text :interpretation, default:""
      t.text :background, default:""
      t.string :category, default:""

      t.timestamps
    end
  end
end
