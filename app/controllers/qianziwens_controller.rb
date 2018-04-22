class QianziwensController < ApplicationController
  before_action :set_qianziwen, only: [:show, :edit, :update, :destroy]

  # GET /qianziwens
  def index
    @page = params[:page]
    @qianziwens = Qianziwen.order(:id).page(@page)
  end

  # GET /qianziwens/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /qianziwens/new
  def new
    @qianziwen = Qianziwen.new
  end

  # GET /qianziwens/1/edit
  def edit
  end

  # POST /qianziwens
  def create
    @qianziwen = Qianziwen.new(qianziwen_params)

    if @qianziwen.save
      redirect_to @qianziwen, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /qianziwens/1
  def update
    if @qianziwen.update(qianziwen_params)
      redirect_to @qianziwen, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /qianziwens/1
  def destroy
    @qianziwen.destroy
    redirect_to qianziwens_url, notice: "删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_qianziwen
      @qianziwen = Qianziwen.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def qianziwen_params
      params.require(:qianziwen).permit(:name, :author, :content, :commentary, :translation, :appreciation, :interpretation)
    end
end
