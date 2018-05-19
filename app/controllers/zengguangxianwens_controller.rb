class ZengguangxianwensController < ApplicationController
  before_action :set_zengguangxianwen, only: [:show, :edit, :update, :destroy]

  # GET /zengguangxianwens
  def index
    @page = params[:page]
    @zengguangxianwens = Zengguangxianwen.order(:id).page(@page)
  end

  # GET /zengguangxianwens/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /zengguangxianwens/new
  def new
    @zengguangxianwen = Zengguangxianwen.new
  end

  # GET /zengguangxianwens/1/edit
  def edit
  end

  # POST /zengguangxianwens
  def create
    @zengguangxianwen = Zengguangxianwen.new(zengguangxianwen_params)

    if @zengguangxianwen.save
      redirect_to @zengguangxianwen, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /zengguangxianwens/1
  def update
    if @zengguangxianwen.update(zengguangxianwen_params)
      redirect_to @zengguangxianwen, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /zengguangxianwens/1
  def destroy
    @zengguangxianwen.destroy
    redirect_to zengguangxianwens_url, notice: "删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_zengguangxianwen
      @zengguangxianwen = Zengguangxianwen.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def zengguangxianwen_params
      params.require(:zengguangxianwen).permit(:name, :chapter, :content, :commentary, :translation, :appreciation, :interpretation)
    end
end
