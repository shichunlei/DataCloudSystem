class VillagesController < ApplicationController
  before_action :set_village, only: [:show, :edit, :update, :destroy]

  # GET /villages
  def index
    @page = params[:page]
    @villages = Village.order(:id).page(@page).per(30)
  end

  # GET /villages/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /villages/new
  def new
    @village = Village.new
  end

  # GET /villages/1/edit
  def edit
  end

  # POST /villages
  def create
    @village = Village.new(village_params)

    if @village.save
      redirect_to @village, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /villages/1
  def update
    if @village.update(village_params)
      redirect_to @village, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /villages/1
  def destroy
    @village.destroy
    redirect_to villages_url, notice: "删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_village
      @village = Village.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def village_params
      params.require(:village).permit(:name, :no, :town_id, :code_no)
    end
end
