class ZuozhuansController < ApplicationController
  before_action :set_zuozhuan, only: [:show, :edit, :update, :destroy]

  # GET /zuozhuans
  def index
    @page = params[:page]
    @zuozhuans = Zuozhuan.order(:id).page(@page).per(30)
  end

  # GET /zuozhuans/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /zuozhuans/new
  def new
    @zuozhuan = Zuozhuan.new
  end

  # GET /zuozhuans/1/edit
  def edit
  end

  # POST /zuozhuans
  def create
    @zuozhuan = Zuozhuan.new(zuozhuan_params)

    if @zuozhuan.save
      redirect_to @zuozhuan, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /zuozhuans/1
  def update
    if @zuozhuan.update(zuozhuan_params)
      redirect_to @zuozhuan, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /zuozhuans/1
  def destroy
    @zuozhuan.destroy
    redirect_to zuozhuans_url, notice: "删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_zuozhuan
      @zuozhuan = Zuozhuan.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def zuozhuan_params
      params.require(:zuozhuan).permit(:name, :chapter, :author, :content, :commentary, :appreciation, :translation, :interpretation)
    end
end
