class RecipeClassify < ApplicationRecord
  belongs_to :recipe_classify
  has_many :recipe_classifies
end
