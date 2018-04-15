json.extract! recipe_material, :id, :recipe_id, :mname, :mtype, :amount, :created_at, :updated_at
json.url recipe_material_url(recipe_material, format: :json)