class ZhuangzisController < ApplicationController
  before_action :set_zhuangzi, only: [:show, :edit, :update, :destroy]
  # GET /zhuangzis
  def index
    @page = params[:page]
    @zhuangzis = Zhuangzi.order(:id).page(@page)
  end
  # GET /zhuangzis/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /zhuangzis/new
  def new
    @zhuangzi = Zhuangzi.new
  end

  # GET /zhuangzis/1/edit
  def edit
  end

  # POST /zhuangzis
  def create
    @zhuangzi = Zhuangzi.new(zhuangzi_params)

    if @zhuangzi.save
      redirect_to @zhuangzi, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /zhuangzis/1
  def update
    if @zhuangzi.update(zhuangzi_params)
      redirect_to @zhuangzi, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /zhuangzis/1
  def destroy
    @zhuangzi.destroy
    redirect_to zhuangzis_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_zhuangzi
      @zhuangzi = Zhuangzi.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def zhuangzi_params
      params.require(:zhuangzi).permit(:chapter, :parent_chapter, :name, :content, :commentary, :translation, :appreciation, :interpretation)
    end
end
