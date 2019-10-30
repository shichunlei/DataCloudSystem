class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :name, default:""
      t.attachment :image
      t.string :author, default:""
      t.string :dynasty, default:""
      t.string :category, default:""
      t.string :sub_category, default:""
      t.string :tag, default:""
      t.integer :chapter, default:0
      t.integer :section, default:0
      t.text :interpretation, default: ""
      t.text :background, default: ""

      t.timestamps
    end
  end
end
