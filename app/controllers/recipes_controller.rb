class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  # GET /recipes
  def index
    @page = params[:page]
    @recipes = Recipe.order(:id).page(@page)
  end
  # GET /recipes/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  # GET /recipes/1/edit
  def edit
  end

  # POST /recipes
  def create
    @recipe = Recipe.new(recipe_params)

    if @recipe.save
      redirect_to @recipe, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /recipes/1
  def update
    if @recipe.update(recipe_params)
      redirect_to @recipe, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /recipes/1
  def destroy
    @recipe.destroy
    redirect_to recipes_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def recipe_params
      params.require(:recipe).permit(:name, :recipe_classify_id, :peoplenum, :preparetime, :cookingtime, :content, :pic, :tag)
    end
end
