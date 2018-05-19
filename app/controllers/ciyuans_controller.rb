class CiyuansController < ApplicationController
  before_action :set_ciyuan, only: [:show, :edit, :update, :destroy]

  # GET /ciyuans
  def index
    @page = params[:page]
    @ciyuans = Ciyuan.order(:id).page(@page)
  end

  # GET /ciyuans/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /ciyuans/new
  def new
    @ciyuan = Ciyuan.new
  end

  # GET /ciyuans/1/edit
  def edit
  end

  # POST /ciyuans
  def create
    @ciyuan = Ciyuan.new(ciyuan_params)

    if @ciyuan.save
      redirect_to @ciyuan, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /ciyuans/1
  def update
    if @ciyuan.update(ciyuan_params)
      redirect_to @ciyuan, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /ciyuans/1
  def destroy
    @ciyuan.destroy
    redirect_to ciyuans_url, notice: "删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ciyuan
      @ciyuan = Ciyuan.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def ciyuan_params
      params.require(:ciyuan).permit(:name, :author, :chapter, :content, :commentary, :translation, :appreciation, :interpretation)
    end
end
