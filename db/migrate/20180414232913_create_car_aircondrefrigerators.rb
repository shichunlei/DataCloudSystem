class CreateCarAircondrefrigerators < ActiveRecord::Migration[5.0]
  def change
    create_table :car_aircondrefrigerators do |t|
      t.references :car_model, foreign_key: true
      t.string :airconditioningcontrolmode, default:""
      t.string :tempzonecontrol, default:""
      t.string :rearairconditioning, default:""
      t.string :reardischargeoutlet, default:""
      t.string :airconditioning, default:""
      t.string :airpurifyingdevice, default:""
      t.string :carrefrigerator, default:""

      t.timestamps
    end
  end
end
