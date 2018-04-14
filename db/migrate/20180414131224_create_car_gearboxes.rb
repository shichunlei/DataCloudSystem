class CreateCarGearboxes < ActiveRecord::Migration[5.0]
  def change
    create_table :car_gearboxes do |t|
      t.references :car_model, foreign_key: true
      t.string :gearbox, default:""
      t.string :shiftpaddles, default:""

      t.timestamps
    end
  end
end
