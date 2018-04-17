class CreateRecipeProcesses < ActiveRecord::Migration[5.0]
  def change
    create_table :recipe_processes do |t|
      t.references :recipe, foreign_key: true
      t.text :pcontent, default:""
      t.string :pic, default:""

      t.timestamps
    end
  end
end
