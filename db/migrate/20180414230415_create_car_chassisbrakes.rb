class CreateCarChassisbrakes < ActiveRecord::Migration[5.0]
  def change
    create_table :car_chassisbrakes do |t|
      t.references :car_model, foreign_key: true
      t.string :bodystructure, default:""
      t.string :powersteering, default:""
      t.string :frontbraketype, default:""
      t.string :rearbraketype, default:""
      t.string :parkingbraketype, default:""
      t.string :drivemode, default:""
      t.string :airsuspension, default:""
      t.string :adjustablesuspension, default:""
      t.string :frontsuspensiontype, default:""
      t.string :rearsuspensiontype, default:""
      t.string :centerdifferentiallock, default:""

      t.timestamps
    end
  end
end
