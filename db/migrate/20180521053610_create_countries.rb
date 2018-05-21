class CreateCountries < ActiveRecord::Migration[5.0]
  def change
    create_table :countries do |t|
      t.string :name, default:""
      t.string :enname, default:""
      t.string :area, default:""
      t.string :enarea, default:""
      t.text :info, default:""
      t.string :flag, default:""
      t.text :finfo, default:""
      t.text :emblem, default:""
      t.text :einfo, default:""
      t.string :anthems, default:""
      t.string :lyrics, default:""
      t.string :compose, default:""
      t.text :lrc, default:""
      t.text :otherlrc, default:""

      t.timestamps
    end
  end
end
