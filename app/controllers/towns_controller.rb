class TownsController < ApplicationController
  before_action :set_town, only: [:show, :edit, :update, :destroy]

  # GET /towns
  def index
    @page = params[:page]
    @towns = Town.order(:id).page(@page).per(30)
  end

  # GET /towns/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /towns/new
  def new
    @town = Town.new
  end

  # GET /towns/1/edit
  def edit
  end

  # POST /towns
  def create
    @town = Town.new(town_params)

    if @town.save
      redirect_to @town, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /towns/1
  def update
    if @town.update(town_params)
      redirect_to @town, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /towns/1
  def destroy
    @town.destroy
    redirect_to towns_url, notice: "删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_town
      @town = Town.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def town_params
      params.require(:town).permit(:name, :no, :county_id)
    end
end
