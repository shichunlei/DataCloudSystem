class CreateCarDrivingauxiliaries < ActiveRecord::Migration[5.0]
  def change
    create_table :car_drivingauxiliaries do |t|
      t.references :car_model, foreign_key: true
      t.string :abs, default:""
      t.string :ebd, default:""
      t.string :brakeassist, default:""
      t.string :tractioncontrol, default:""
      t.string :esp, default:""
      t.string :eps, default:""
      t.string :automaticparking, default:""
      t.string :hillstartassist, default:""
      t.string :hilldescent, default:""
      t.string :frontparkingradar, default:""
      t.string :reversingradar, default:""
      t.string :reverseimage, default:""
      t.string :panoramiccamera, default:""
      t.string :cruisecontrol, default:""
      t.string :adaptivecruise, default:""
      t.string :gps, default:""
      t.string :automaticparkingintoplace, default:""
      t.string :ldws, default:""
      t.string :activebraking, default:""
      t.string :integralactivesteering, default:""
      t.string :nightvisionsystem, default:""
      t.string :blindspotdetection, default:""

      t.timestamps
    end
  end
end
