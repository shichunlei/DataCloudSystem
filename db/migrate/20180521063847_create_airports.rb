class CreateAirports < ActiveRecord::Migration[5.0]
  def change
    create_table :airports do |t|
      t.string :name, default:""
      t.string :iata, default:""
      t.string :icao, default:""
      t.string :other_name, default:""
      t.references :country, foreign_key: true
      t.string :city_name, default:""
      t.text :intro, default:""

      t.timestamps
    end
  end
end
