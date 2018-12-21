class LijisController < ApplicationController
  before_action :set_liji, only: [:show, :edit, :update, :destroy]

  # GET /lijis
  def index
    @page = params[:page]
    @lijis = Liji.order(:id).page(@page)
  end

  # GET /lijis/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /lijis/new
  def new
    @liji = Liji.new
  end

  # GET /lijis/1/edit
  def edit
  end

  # POST /lijis
  def create
    @liji = Liji.new(liji_params)

    if @liji.save
      redirect_to @liji, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /lijis/1
  def update
    if @liji.update(liji_params)
      redirect_to @liji, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /lijis/1
  def destroy
    @liji.destroy
    redirect_to lijis_url, notice: "删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_liji
      @liji = Liji.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def liji_params
      params.require(:liji).permit(:name, :content, :commentary, :translation, :appreciation, :interpretation)
    end
end
