class CreateCarLights < ActiveRecord::Migration[5.0]
  def change
    create_table :car_lights do |t|
      t.references :car_model, foreign_key: true
      t.string :headlighttype, default:""
      t.string :optionalheadlighttype, default:""
      t.string :headlightautomaticopen, default:""
      t.string :headlightautomaticclean, default:""
      t.string :headlightdelayoff, default:""
      t.string :headlightdynamicsteering, default:""
      t.string :headlightilluminationadjustment, default:""
      t.string :headlightdimming, default:""
      t.string :frontfoglight, default:""
      t.string :readinglight, default:""
      t.string :interiorairlight, default:""
      t.string :daytimerunninglight, default:""
      t.string :ledtaillight, default:""
      t.string :lightsteeringassist, default:""

      t.timestamps
    end
  end
end
