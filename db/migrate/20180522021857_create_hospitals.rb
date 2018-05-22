class CreateHospitals < ActiveRecord::Migration[5.0]
  def change
    create_table :hospitals do |t|
      t.string :name, default:""
      t.string :nature, default:""
      t.string :grade, default:""
      t.string :province, default:""
      t.string :city, default:""
      t.string :area, default:""
      t.string :address, default:""
      t.string :phone, default:""
      t.string :dean, default:""
      t.text :about, default:""
      t.string :specialist, default:""
      t.string :year, default:""
      t.string :department, default:""
      t.string :equipment, default:""
      t.integer :bed_number, default: -1
      t.integer :medical_workers, default: -1
      t.string :honor, default:""
      t.string :annual_outpatient_service, default:""
      t.integer :department_number, default: -1
      t.string :health_insurance, default:""

      t.timestamps
    end
  end
end
