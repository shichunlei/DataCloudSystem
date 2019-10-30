class CreateBookDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :book_details do |t|
      t.references :book, foreign_key: true
      t.string :chapter, default:""
      t.string :name, default:""
      t.string :author, default:""
      t.string :sid, default:""
      t.string :category, default:""
      t.string :dynasty, default:""
      t.text :content, default:""
      t.text :commentary, default:""
      t.text :translation, default:""
      t.text :appreciation, default:""
      t.text :interpretation, default:""
      t.text :background, default:""
      t.string :tags, default:""

      t.timestamps
    end
  end
end
