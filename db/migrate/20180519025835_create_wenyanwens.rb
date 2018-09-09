class CreateWenyanwens < ActiveRecord::Migration[5.0]
  def change
    create_table :wenyanwens do |t|
      t.string :name, default:""
      t.string :author, default:""
      t.text :content, default:""
      t.text :commentary, default:""
      t.text :translation, default:""
      t.text :appreciation, default:""
      t.text :interpretation, default:""
      t.text :background, default:""
      t.string :dynasty, default:""
      t.string :sid, default:""
      t.string :tags, default:""

      t.timestamps
    end
  end
end
