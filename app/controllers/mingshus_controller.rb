class MingshusController < ApplicationController
  before_action :set_mingshu, only: [:show, :edit, :update, :destroy]

  # GET /mingshus
  def index
    @page = params[:page]
    @mingshus = Mingshu.order(:id).page(@page)
  end

  # GET /mingshus/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /mingshus/new
  def new
    @mingshu = Mingshu.new
  end

  # GET /mingshus/1/edit
  def edit
  end

  # POST /mingshus
  def create
    @mingshu = Mingshu.new(mingshu_params)

    if @mingshu.save
      redirect_to @mingshu, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /mingshus/1
  def update
    if @mingshu.update(mingshu_params)
      redirect_to @mingshu, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /mingshus/1
  def destroy
    @mingshu.destroy
    redirect_to mingshus_url, notice: "删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mingshu
      @mingshu = Mingshu.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def mingshu_params
      params.require(:mingshu).permit(:name, :author, :chapter, :content, :commentary, :translation, :appreciation, :interpretation)
    end
end
