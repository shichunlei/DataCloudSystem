class ZixiayizhuansController < ApplicationController
  before_action :set_zixiayizhuan, only: [:show, :edit, :update, :destroy]

  # GET /zixiayizhuans
  def index
    @page = params[:page]
    @zixiayizhuans = Zixiayizhuan.order(:id).page(@page)
  end

  # GET /zixiayizhuans/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /zixiayizhuans/new
  def new
    @zixiayizhuan = Zixiayizhuan.new
  end

  # GET /zixiayizhuans/1/edit
  def edit
  end

  # POST /zixiayizhuans
  def create
    @zixiayizhuan = Zixiayizhuan.new(zixiayizhuan_params)

    if @zixiayizhuan.save
      redirect_to @zixiayizhuan, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /zixiayizhuans/1
  def update
    if @zixiayizhuan.update(zixiayizhuan_params)
      redirect_to @zixiayizhuan, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /zixiayizhuans/1
  def destroy
    @zixiayizhuan.destroy
    redirect_to zixiayizhuans_url, notice: "删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_zixiayizhuan
      @zixiayizhuan = Zixiayizhuan.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def zixiayizhuan_params
      params.require(:zixiayizhuan).permit(:chapter, :name, :author, :content, :commentary, :translation, :appreciation, :interpretation)
    end
end
