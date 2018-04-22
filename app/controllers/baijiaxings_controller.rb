class BaijiaxingsController < ApplicationController
  before_action :set_baijiaxing, only: [:show, :edit, :update, :destroy]

  # GET /baijiaxings
  def index
    @page = params[:page]
    @baijiaxings = Baijiaxing.order(:id).page(@page)
  end

  # GET /baijiaxings/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /baijiaxings/new
  def new
    @baijiaxing = Baijiaxing.new
  end

  # GET /baijiaxings/1/edit
  def edit
  end

  # POST /baijiaxings
  def create
    @baijiaxing = Baijiaxing.new(baijiaxing_params)

    if @baijiaxing.save
      redirect_to @baijiaxing, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /baijiaxings/1
  def update
    if @baijiaxing.update(baijiaxing_params)
      redirect_to @baijiaxing, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /baijiaxings/1
  def destroy
    @baijiaxing.destroy
    redirect_to baijiaxings_url, notice: "删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_baijiaxing
      @baijiaxing = Baijiaxing.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def baijiaxing_params
      params.require(:baijiaxing).permit(:name, :author, :source, :celebrity, :distributing)
    end
end
