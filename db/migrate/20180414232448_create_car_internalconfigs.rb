class CreateCarInternalconfigs < ActiveRecord::Migration[5.0]
  def change
    create_table :car_internalconfigs do |t|
      t.references :car_model, foreign_key: true
      t.string :steeringwheelbeforeadjustment, default:""
      t.string :steeringwheelupadjustment, default:""
      t.string :steeringwheeladjustmentmode, default:""
      t.string :steeringwheelmemory, default:""
      t.string :steeringwheelmaterial, default:""
      t.string :steeringwheelmultifunction, default:""
      t.string :steeringwheelheating, default:""
      t.string :computerscreen, default:""
      t.string :huddisplay, default:""
      t.string :interiorcolor, default:""
      t.string :rearcupholder, default:""
      t.string :supplyvoltage, default:""

      t.timestamps
    end
  end
end
