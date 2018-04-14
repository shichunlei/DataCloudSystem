class CreateCarTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :car_types do |t|
      t.string :name, default:""
      t.string :fullname, default:""
      t.string :parentname, default:""
      t.string :logo, default:""
      t.string :salestate, default:""
      t.references :car_brand, foreign_key: true

      t.timestamps
    end
  end
end
