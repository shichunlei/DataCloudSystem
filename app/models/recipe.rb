class Recipe < ApplicationRecord
  belongs_to :recipe_classify

  def process
    RecipeProcess.where(recipe_id:self.id).order(:id).as_json(:except => [:created_at, :updated_at, :recipe_id])
  end

  def material
    RecipeMaterial.where(recipe_id:self.id).order(:id).as_json(:except => [:created_at, :updated_at, :recipe_id])
  end
end
