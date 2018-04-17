class CreateDaodejings < ActiveRecord::Migration[5.0]
  def change
    create_table :daodejings do |t|
      t.string :name, default:""
      t.text :content, default:""
      t.text :commentary, default:""
      t.text :translation, default:""
      t.text :appreciation, default:""
      t.text :interpretation, default:""

      t.timestamps
    end
  end
end
