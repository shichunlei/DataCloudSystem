class CreateZixiayizhuans < ActiveRecord::Migration[5.0]
  def change
    create_table :zixiayizhuans do |t|
      t.string :chapter, default:""
      t.string :name, default:""
      t.string :author, default:""
      t.text :content, default:""
      t.text :commentary, default:""
      t.text :translation, default:""
      t.text :appreciation, default:""
      t.text :interpretation, default:""

      t.timestamps
    end
  end
end
