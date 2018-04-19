class MiyusController < ApplicationController
  before_action :set_miyu, only: [:show, :edit, :update, :destroy]
  # GET /miyus
  def index
    @page = params[:page]
    @miyus = Miyu.order(:id).page(@page)
  end
  # GET /miyus/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /miyus/new
  def new
    @miyu = Miyu.new
  end

  # GET /miyus/1/edit
  def edit
  end

  # POST /miyus
  def create
    @miyu = Miyu.new(miyu_params)

    if @miyu.save
      redirect_to @miyu, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /miyus/1
  def update
    if @miyu.update(miyu_params)
      redirect_to @miyu, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /miyus/1
  def destroy
    @miyu.destroy
    redirect_to miyus_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_miyu
      @miyu = Miyu.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def miyu_params
      params.require(:miyu).permit(:content, :answer, :miyu_classify_id)
    end
end
