class CreateCarBasics < ActiveRecord::Migration[5.0]
  def change
    create_table :car_basics do |t|
      t.string :price, default:""
      t.string :saleprice, default:""
      t.string :warrantypolicy, default:""
      t.string :vechiletax, default:""
      t.string :displacement, default:""
      t.string :gearbox, default:""
      t.string :comfuelconsumption, default:""
      t.string :userfuelconsumption, default:""
      t.string :officialaccelerationtime100, default:""
      t.string :maxspeed, default:""
      t.string :seatnum, default:""
      t.references :car_model, foreign_key: true

      t.timestamps
    end
  end
end
