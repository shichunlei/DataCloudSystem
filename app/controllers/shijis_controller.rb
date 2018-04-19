class ShijisController < ApplicationController
  before_action :set_shiji, only: [:show, :edit, :update, :destroy]
  # GET /shijis
  def index
    @page = params[:page]
    @shijis = Shiji.order(:id).page(@page)
  end
  # GET /shijis/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /shijis/new
  def new
    @shiji = Shiji.new
  end

  # GET /shijis/1/edit
  def edit
  end

  # POST /shijis
  def create
    @shiji = Shiji.new(shiji_params)

    if @shiji.save
      redirect_to @shiji, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /shijis/1
  def update
    if @shiji.update(shiji_params)
      redirect_to @shiji, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /shijis/1
  def destroy
    @shiji.destroy
    redirect_to shijis_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shiji
      @shiji = Shiji.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def shiji_params
      params.require(:shiji).permit(:name, :chapter, :content, :commentary, :appreciation, :translation, :interpretation)
    end
end
