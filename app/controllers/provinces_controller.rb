class ProvincesController < ApplicationController
  before_action :set_province, only: [:show, :edit, :update, :destroy]

  # GET /provinces
  def index
    @page = params[:page]
    @provinces = Province.order(:id).page(@page).per(30)
  end

  # GET /provinces/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /provinces/new
  def new
    @province = Province.new
  end

  # GET /provinces/1/edit
  def edit
  end

  # POST /provinces
  def create
    @province = Province.new(province_params)

    if @province.save
      redirect_to @province, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /provinces/1
  def update
    if @province.update(province_params)
      redirect_to @province, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /provinces/1
  def destroy
    @province.destroy
    redirect_to provinces_url, notice: "删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_province
      @province = Province.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def province_params
      params.require(:province).permit(:name, :no, :country_id)
    end
end
