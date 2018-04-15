class CreateCarSaves < ActiveRecord::Migration[5.0]
  def change
    create_table :car_saves do |t|
      t.references :car_model, foreign_key: true
      t.string :airbagdrivingposition, default:""
      t.string :airbagfrontpassenger, default:""
      t.string :airbagfrontside, default:""
      t.string :airbagfronthead, default:""
      t.string :airbagknee, default:""
      t.string :airbagrearside, default:""
      t.string :airbagrearhead, default:""
      t.string :safetybeltprompt, default:""
      t.string :safetybeltlimiting, default:""
      t.string :safetybeltpretightening, default:""
      t.string :frontsafetybeltadjustment, default:""
      t.string :rearsafetybelt, default:""
      t.string :tirepressuremonitoring, default:""
      t.string :zeropressurecontinued, default:""
      t.string :centrallocking, default:""
      t.string :childlock, default:""
      t.string :remotekey, default:""
      t.string :keylessentry, default:""
      t.string :keylessstart, default:""
      t.string :engineantitheft, default:""

      t.timestamps
    end
  end
end
