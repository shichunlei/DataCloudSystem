class RecipeMaterialsController < ApplicationController
  before_action :set_recipe_material, only: [:show, :edit, :update, :destroy]
  # GET /recipe_materials
  def index
    @page = params[:page]
    @recipe_materials = RecipeMaterial.order(:id).page(@page)
  end
  # GET /recipe_materials/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /recipe_materials/new
  def new
    @recipe_material = RecipeMaterial.new
  end

  # GET /recipe_materials/1/edit
  def edit
  end

  # POST /recipe_materials
  def create
    @recipe_material = RecipeMaterial.new(recipe_material_params)

    if @recipe_material.save
      redirect_to @recipe_material, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /recipe_materials/1
  def update
    if @recipe_material.update(recipe_material_params)
      redirect_to @recipe_material, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /recipe_materials/1
  def destroy
    @recipe_material.destroy
    redirect_to recipe_materials_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe_material
      @recipe_material = RecipeMaterial.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def recipe_material_params
      params.require(:recipe_material).permit(:recipe_id, :mname, :mtype, :amount)
    end
end
