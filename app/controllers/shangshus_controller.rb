class ShangshusController < ApplicationController
  before_action :set_shangshu, only: [:show, :edit, :update, :destroy]

  # GET /shangshus
  def index
    @page = params[:page]
    @shangshus = Shangshu.order(:id).page(@page)
  end

  # GET /shangshus/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /shangshus/new
  def new
    @shangshu = Shangshu.new
  end

  # GET /shangshus/1/edit
  def edit
  end

  # POST /shangshus
  def create
    @shangshu = Shangshu.new(shangshu_params)

    if @shangshu.save
      redirect_to @shangshu, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /shangshus/1
  def update
    if @shangshu.update(shangshu_params)
      redirect_to @shangshu, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /shangshus/1
  def destroy
    @shangshu.destroy
    redirect_to shangshus_url, notice: "删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shangshu
      @shangshu = Shangshu.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def shangshu_params
      params.require(:shangshu).permit(:chapter, :name, :author, :content, :commentary, :translation, :appreciation, :interpretation)
    end
end
