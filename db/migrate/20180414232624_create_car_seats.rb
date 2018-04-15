class CreateCarSeats < ActiveRecord::Migration[5.0]
  def change
    create_table :car_seats do |t|
      t.references :car_model, foreign_key: true
      t.string :sportseat, default:""
      t.string :seatmaterial, default:""
      t.string :seatheightadjustment, default:""
      t.string :driverseatadjustmentmode, default:""
      t.string :auxiliaryseatadjustmentmode, default:""
      t.string :driverseatlumbarsupportadjustment, default:""
      t.string :driverseatshouldersupportadjustment, default:""
      t.string :frontseatheadrestadjustment, default:""
      t.string :rearseatadjustmentmode, default:""
      t.string :rearseatreclineproportion, default:""
      t.string :rearseatangleadjustment, default:""
      t.string :frontseatcenterarmrest, default:""
      t.string :rearseatcenterarmrest, default:""
      t.string :seatventilation, default:""
      t.string :seatheating, default:""
      t.string :seatmassage, default:""
      t.string :electricseatmemory, default:""
      t.string :childseatfixdevice, default:""
      t.string :thirdrowseat, default:""

      t.timestamps
    end
  end
end
