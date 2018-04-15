class CreateCarEntcoms < ActiveRecord::Migration[5.0]
  def change
    create_table :car_entcoms do |t|
      t.references :car_model, foreign_key: true
      t.string :locationservice, default:""
      t.string :bluetooth, default:""
      t.string :externalaudiointerface, default:""
      t.string :builtinharddisk, default:""
      t.string :cartv, default:""
      t.string :speakernum, default:""
      t.string :audiobrand, default:""
      t.string :dvd, default:""
      t.string :cd, default:""
      t.string :consolelcdscreen, default:""
      t.string :rearlcdscreen, default:""

      t.timestamps
    end
  end
end
