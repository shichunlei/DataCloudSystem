class CreateCarEngines < ActiveRecord::Migration[5.0]
  def change
    create_table :car_engines do |t|
      t.references :car_model, foreign_key: true
      t.string :position, default:""
      t.string :model, default:""
      t.string :displacement, default:""
      t.string :displacementml, default:""
      t.string :intakeform, default:""
      t.string :cylinderarrangetype, default:""
      t.string :cylindernum, default:""
      t.string :valvetrain, default:""
      t.string :valvestructure, default:""
      t.string :compressionratio, default:""
      t.string :bore, default:""
      t.string :stroke, default:""
      t.string :maxhorsepower, default:""
      t.string :maxpower, default:""
      t.string :maxpowerspeed, default:""
      t.string :maxtorque, default:""
      t.string :maxtorquespeed, default:""
      t.string :fueltype, default:""
      t.string :fuelgrade, default:""
      t.string :fuelmethod, default:""
      t.string :fueltankcapacity, default:""
      t.string :cylinderheadmaterial, default:""
      t.string :cylinderbodymaterial, default:""
      t.string :environmentalstandards, default:""
      t.string :startstopsystem, default:""

      t.timestamps
    end
  end
end
