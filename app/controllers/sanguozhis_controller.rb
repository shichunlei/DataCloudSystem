class SanguozhisController < ApplicationController
  before_action :set_sanguozhi, only: [:show, :edit, :update, :destroy]
  # GET /sanguozhis
  def index
    @page = params[:page]
    @sanguozhis = Sanguozhi.order(:id).page(@page)
  end
  # GET /sanguozhis/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /sanguozhis/new
  def new
    @sanguozhi = Sanguozhi.new
  end

  # GET /sanguozhis/1/edit
  def edit
  end

  # POST /sanguozhis
  def create
    @sanguozhi = Sanguozhi.new(sanguozhi_params)

    if @sanguozhi.save
      redirect_to @sanguozhi, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /sanguozhis/1
  def update
    if @sanguozhi.update(sanguozhi_params)
      redirect_to @sanguozhi, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /sanguozhis/1
  def destroy
    @sanguozhi.destroy
    redirect_to sanguozhis_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sanguozhi
      @sanguozhi = Sanguozhi.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def sanguozhi_params
      params.require(:sanguozhi).permit(:name, :chapter, :content, :commentary, :appreciation, :translation, :interpretation)
    end
end
