class CreateSanshiliujis < ActiveRecord::Migration[5.0]
  def change
    create_table :sanshiliujis do |t|
      t.string :name, default:""
      t.string :chapter, default:""
      t.attachment :gallery
      t.text :analogy, default:""
      t.text :content, default:""
      t.text :commentary, default:""
      t.text :comment, default:""
      t.text :appreciation, default:""
      t.text :translation, default:""
      t.text :interpretation, default:""
      t.text :story, default:""
      t.text :simple_explanation, default:""

      t.timestamps
    end
  end
end
