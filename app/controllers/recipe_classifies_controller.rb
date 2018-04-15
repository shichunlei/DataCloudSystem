class RecipeClassifiesController < ApplicationController
  before_action :set_recipe_classify, only: [:show, :edit, :update, :destroy]

  # GET /recipe_classifies
  def index
    @page = params[:page]
    @recipe_classifies = RecipeClassify.order(:id).page(@page)
  end

  # GET /recipe_classifies/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /recipe_classifies/new
  def new
    @recipe_classify = RecipeClassify.new
  end

  # GET /recipe_classifies/1/edit
  def edit
  end

  # POST /recipe_classifies
  def create
    @recipe_classify = RecipeClassify.new(recipe_classify_params)

    if @recipe_classify.save
      redirect_to @recipe_classify, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /recipe_classifies/1
  def update
    if @recipe_classify.update(recipe_classify_params)
      redirect_to @recipe_classify, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /recipe_classifies/1
  def destroy
    @recipe_classify.destroy
    redirect_to recipe_classifies_url, notice: "删除成功."
  end

  def find_classify
    list = RecipeClassify.where("recipe_classify_id IS NOT NULL").order(:id).limit(20)
    render json:list.to_json(:only => [:id, :name])
  end

  def search_classify
    list = RecipeClassify.where("recipe_classify_id IS NOT NULL AND name LIKE '%#{params[:keyword]}%'").order(:id).limit(20)
    render json:list.to_json(:only => [:id, :name])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe_classify
      @recipe_classify = RecipeClassify.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def recipe_classify_params
      params.require(:recipe_classify).permit(:name, :recipe_classify_id)
    end
end
