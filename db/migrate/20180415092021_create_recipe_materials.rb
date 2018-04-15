class CreateRecipeMaterials < ActiveRecord::Migration[5.0]
  def change
    create_table :recipe_materials do |t|
      t.references :recipe, foreign_key: true
      t.string :mname, default:""
      t.integer :mtype, default:0
      t.string :amount, default:""

      t.timestamps
    end
  end
end
