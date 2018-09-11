class CreateFoodNutritions < ActiveRecord::Migration[5.0]
  def change
    create_table :food_nutritions do |t|
      t.string :food_name, default:""
      t.string :category, default:""
      t.string :heat, default:""
      t.string :thiamine, default:""
      t.string :calcium, default:""
      t.string :protein, default:""
      t.string :riboflavin, default:""
      t.string :magnesium, default:""
      t.string :fat, default:""
      t.string :niacin, default:""
      t.string :iron, default:""
      t.string :carbohydrate, default:""
      t.string :vc, default:""
      t.string :manganese, default:""
      t.string :fiber, default:""
      t.string :ve, default:""
      t.string :zinc, default:""
      t.string :va, default:""
      t.string :cholesterol, default:""
      t.string :copper, default:""
      t.string :carotene, default:""
      t.string :potassium, default:""
      t.string :phosphorus, default:""
      t.string :retinol_equivalent, default:""
      t.string :sodium, default:""
      t.string :selenium, default:""

      t.timestamps
    end
  end
end
