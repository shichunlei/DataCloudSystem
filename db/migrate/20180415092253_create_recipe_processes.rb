class CreateRecipeProcesses < ActiveRecord::Migration[5.0]
  def change
    create_table :recipe_processes do |t|
      t.references :recipe, foreign_key: true
      t.text :pcontent
      t.string :pic

      t.timestamps
    end
  end
end
