class ZhouyisController < ApplicationController
  before_action :set_zhouyi, only: [:show, :edit, :update, :destroy]
  # GET /zhouyis
  def index
    @page = params[:page]
    @zhouyis = Zhouyi.order(:id).page(@page)
  end
  # GET /zhouyis/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /zhouyis/new
  def new
    @zhouyi = Zhouyi.new
  end

  # GET /zhouyis/1/edit
  def edit
  end

  # POST /zhouyis
  def create
    @zhouyi = Zhouyi.new(zhouyi_params)

    if @zhouyi.save
      redirect_to @zhouyi, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /zhouyis/1
  def update
    if @zhouyi.update(zhouyi_params)
      redirect_to @zhouyi, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /zhouyis/1
  def destroy
    @zhouyi.destroy
    redirect_to zhouyis_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_zhouyi
      @zhouyi = Zhouyi.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def zhouyi_params
      params.require(:zhouyi).permit(:name, :content, :commentary, :appreciation, :translation, :interpretation)
    end
end
