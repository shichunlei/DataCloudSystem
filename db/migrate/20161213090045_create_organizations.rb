class CreateOrganizations < ActiveRecord::Migration[5.0]
  def change
    create_table :organizations do |t|
      t.string :name, default:""
      t.text :description, default:""
      t.string :contact, default:""
      t.string :mobile, default:""
      t.string :email, default:""
      t.string :duty_paragraph, default:""
      t.string :web_site, default:""
      t.references :organization, index: true,foreign_key: true

      t.timestamps
    end
  end
end
