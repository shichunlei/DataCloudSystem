class CreateRecipes < ActiveRecord::Migration[5.0]
  def change
    create_table :recipes do |t|
      t.string :name, default:""
      t.references :recipe_classify, foreign_key: true
      t.string :peoplenum, default:""
      t.string :preparetime, default:""
      t.string :cookingtime, default:""
      t.text :content, default:""
      t.string :pic, default:""
      t.text :tag, default:""

      t.timestamps
    end
  end
end
