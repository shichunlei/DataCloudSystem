class YuefusController < ApplicationController
  before_action :set_yuefu, only: [:show, :edit, :update, :destroy]
  # GET /yuefus
  def index
    @page = params[:page]
    @yuefus = Yuefu.order(:id).page(@page).per(30)
  end
  # GET /yuefus/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /yuefus/new
  def new
    @yuefu = Yuefu.new
  end

  # GET /yuefus/1/edit
  def edit
  end

  # POST /yuefus
  def create
    @yuefu = Yuefu.new(yuefu_params)

    if @yuefu.save
      redirect_to @yuefu, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /yuefus/1
  def update
    if @yuefu.update(yuefu_params)
      redirect_to @yuefu, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /yuefus/1
  def destroy
    @yuefu.destroy
    redirect_to yuefus_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_yuefu
      @yuefu = Yuefu.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def yuefu_params
      params.require(:yuefu).permit(:name, :chapter, :content, :commentary, :appreciation, :translation, :interpretation, :background, :tags, :sid, :dynasty, :author)
    end
end
