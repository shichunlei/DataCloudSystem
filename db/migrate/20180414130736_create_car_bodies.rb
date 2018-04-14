class CreateCarBodies < ActiveRecord::Migration[5.0]
  def change
    create_table :car_bodies do |t|
      t.references :car_model, foreign_key: true
      t.string :color, default:""
      t.string :len, default:""
      t.string :width, default:""
      t.string :height, default:""
      t.string :wheelbase, default:""
      t.string :fronttrack, default:""
      t.string :reartrack, default:""
      t.string :weight, default:""
      t.string :fullweight, default:""
      t.string :mingroundclearance, default:""
      t.string :approachangle, default:""
      t.string :departureangle, default:""
      t.string :luggagevolume, default:""
      t.string :luggagemode, default:""
      t.string :luggageopenmode, default:""
      t.string :inductionluggage, default:""
      t.string :doornum, default:""
      t.string :tooftype, default:""
      t.string :hoodtype, default:""
      t.string :roofluggagerack, default:""
      t.string :sportpackage, default:""

      t.timestamps
    end
  end
end
