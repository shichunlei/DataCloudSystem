class RecipeProcessesController < ApplicationController
  before_action :set_recipe_process, only: [:show, :edit, :update, :destroy]
  # GET /recipe_processes
  def index
    @page = params[:page]
    @recipe_processes = RecipeProcess.order(:id).page(@page)
  end
  # GET /recipe_processes/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /recipe_processes/new
  def new
    @recipe_process = RecipeProcess.new
  end

  # GET /recipe_processes/1/edit
  def edit
  end

  # POST /recipe_processes
  def create
    @recipe_process = RecipeProcess.new(recipe_process_params)

    if @recipe_process.save
      redirect_to @recipe_process, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /recipe_processes/1
  def update
    if @recipe_process.update(recipe_process_params)
      redirect_to @recipe_process, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /recipe_processes/1
  def destroy
    @recipe_process.destroy
    redirect_to recipe_processes_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe_process
      @recipe_process = RecipeProcess.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def recipe_process_params
      params.require(:recipe_process).permit(:recipe_id, :pcontent, :pic)
    end
end
