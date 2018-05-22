class CreateSnacks < ActiveRecord::Migration[5.0]
  def change
    create_table :snacks do |t|
      t.string :name, default:""
      t.text :intro, default:""
      t.text :history, default:""
      t.text :practice, default:""

      t.timestamps
    end
  end
end
