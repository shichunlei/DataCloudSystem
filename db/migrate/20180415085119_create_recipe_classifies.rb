class CreateRecipeClassifies < ActiveRecord::Migration[5.0]
  def change
    create_table :recipe_classifies do |t|
      t.string :name, default:""
      t.references :recipe_classify, foreign_key: true

      t.timestamps
    end
  end
end
