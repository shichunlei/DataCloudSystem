class FoodNutritionsController < ApplicationController
  before_action :set_food_nutrition, only: [:show, :edit, :update, :destroy]

  # GET /food_nutritions
  def index
    @page = params[:page]
    @food_nutritions = FoodNutrition.order(:id).page(@page).per(30)
  end

  # GET /food_nutritions/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /food_nutritions/new
  def new
    @food_nutrition = FoodNutrition.new
  end

  # GET /food_nutritions/1/edit
  def edit
  end

  # POST /food_nutritions
  def create
    @food_nutrition = FoodNutrition.new(food_nutrition_params)

    if @food_nutrition.save
      redirect_to @food_nutrition, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /food_nutritions/1
  def update
    if @food_nutrition.update(food_nutrition_params)
      redirect_to @food_nutrition, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /food_nutritions/1
  def destroy
    @food_nutrition.destroy
    redirect_to food_nutritions_url, notice: "删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_food_nutrition
      @food_nutrition = FoodNutrition.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def food_nutrition_params
      params.require(:food_nutrition).permit(:food_name, :category, :heat, :thiamine, :calcium, :protein, :riboflavin, :magnesium, :fat, :niacin, :iron, :carbohydrate, :vc, :manganese, :fiber, :ve, :zinc, :va, :cholesterol, :copper, :carotene, :potassium, :phosphorus, :retinol_equivalent, :sodium, :selenium)
    end
end
