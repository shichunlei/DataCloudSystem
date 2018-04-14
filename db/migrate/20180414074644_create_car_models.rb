class CreateCarModels < ActiveRecord::Migration[5.0]
  def change
    create_table :car_models do |t|
      t.string :name, default:""
      t.string :price, default:""
      t.string :logo, default:""
      t.string :salestate, default:""
      t.string :yeartype, default:""
      t.string :productionstate, default:""
      t.string :sizetype, default:""
      t.references :car_type, foreign_key: true

      t.timestamps
    end
  end
end
