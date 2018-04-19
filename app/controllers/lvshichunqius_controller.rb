class LvshichunqiusController < ApplicationController
  before_action :set_lvshichunqiu, only: [:show, :edit, :update, :destroy]
  # GET /lvshichunqius
  def index
    @page = params[:page]
    @lvshichunqius = Lvshichunqiu.order(:id).page(@page)
  end
  # GET /lvshichunqius/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /lvshichunqius/new
  def new
    @lvshichunqiu = Lvshichunqiu.new
  end

  # GET /lvshichunqius/1/edit
  def edit
  end

  # POST /lvshichunqius
  def create
    @lvshichunqiu = Lvshichunqiu.new(lvshichunqiu_params)

    if @lvshichunqiu.save
      redirect_to @lvshichunqiu, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /lvshichunqius/1
  def update
    if @lvshichunqiu.update(lvshichunqiu_params)
      redirect_to @lvshichunqiu, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /lvshichunqius/1
  def destroy
    @lvshichunqiu.destroy
    redirect_to lvshichunqius_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lvshichunqiu
      @lvshichunqiu = Lvshichunqiu.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def lvshichunqiu_params
      params.require(:lvshichunqiu).permit(:name, :chapter, :content, :commentary, :appreciation, :translation, :interpretation)
    end
end
