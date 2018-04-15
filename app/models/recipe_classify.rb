class RecipeClassify < ApplicationRecord
  belongs_to :recipe_classify
  has_many :recipe_classifies

  def sub_classify
    RecipeClassify.where(recipe_classify_id:self.id).order(:id).as_json(:only => [:id, :name])
  end
end
