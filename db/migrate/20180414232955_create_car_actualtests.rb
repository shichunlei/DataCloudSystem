class CreateCarActualtests < ActiveRecord::Migration[5.0]
  def change
    create_table :car_actualtests do |t|
      t.references :car_model, foreign_key: true
      t.string :accelerationtime100, default:""
      t.string :brakingdistance, default:""

      t.timestamps
    end
  end
end
