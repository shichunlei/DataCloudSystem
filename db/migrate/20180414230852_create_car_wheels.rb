class CreateCarWheels < ActiveRecord::Migration[5.0]
  def change
    create_table :car_wheels do |t|
      t.references :car_model, foreign_key: true
      t.string :fronttiresize, default:""
      t.string :reartiresize, default:""
      t.string :sparetiretype, default:""
      t.string :hubmaterial, default:""

      t.timestamps
    end
  end
end
