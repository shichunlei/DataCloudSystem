class GongyangzhuansController < ApplicationController
  before_action :set_gongyangzhuan, only: [:show, :edit, :update, :destroy]

  # GET /gongyangzhuans
  def index
    @page = params[:page]
    @gongyangzhuans = Gongyangzhuan.order(:id).page(@page)
  end

  # GET /gongyangzhuans/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /gongyangzhuans/new
  def new
    @gongyangzhuan = Gongyangzhuan.new
  end

  # GET /gongyangzhuans/1/edit
  def edit
  end

  # POST /gongyangzhuans
  def create
    @gongyangzhuan = Gongyangzhuan.new(gongyangzhuan_params)

    if @gongyangzhuan.save
      redirect_to @gongyangzhuan, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /gongyangzhuans/1
  def update
    if @gongyangzhuan.update(gongyangzhuan_params)
      redirect_to @gongyangzhuan, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /gongyangzhuans/1
  def destroy
    @gongyangzhuan.destroy
    redirect_to gongyangzhuans_url, notice: "删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gongyangzhuan
      @gongyangzhuan = Gongyangzhuan.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def gongyangzhuan_params
      params.require(:gongyangzhuan).permit(:chapter, :name, :author, :content, :commentary, :translation, :appreciation, :interpretation)
    end
end
