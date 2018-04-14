class CreateCarBrands < ActiveRecord::Migration[5.0]
  def change
    create_table :car_brands do |t|
      t.string :name, default:""
      t.string :initial, default:""
      t.string :logo, default:""

      t.timestamps
    end
  end
end
