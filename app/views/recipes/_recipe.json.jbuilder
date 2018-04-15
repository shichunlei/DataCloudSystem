json.extract! recipe, :id, :name, :recipe_classify_id, :peoplenum, :preparetime, :cookingtime, :content, :pic, :tag, :created_at, :updated_at
json.url recipe_url(recipe, format: :json)