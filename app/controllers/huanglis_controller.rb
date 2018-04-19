class HuanglisController < ApplicationController
  before_action :set_huangli, only: [:show, :edit, :update, :destroy]
  # GET /huanglis
  def index
    @page = params[:page]
    @huanglis = Huangli.order(:id).page(@page)
  end
  # GET /huanglis/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /huanglis/new
  def new
    @huangli = Huangli.new
  end

  # GET /huanglis/1/edit
  def edit
  end

  # POST /huanglis
  def create
    @huangli = Huangli.new(huangli_params)

    if @huangli.save
      redirect_to @huangli, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /huanglis/1
  def update
    if @huangli.update(huangli_params)
      redirect_to @huangli, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /huanglis/1
  def destroy
    @huangli.destroy
    redirect_to huanglis_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_huangli
      @huangli = Huangli.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def huangli_params
      params.require(:huangli).permit(:year, :month, :day, :yangli, :nongli, :star, :taishen, :wuxing, :chong, :sha, :shengxiao, :jiri, :zhiri, :xiongshen, :jishenyiqu, :caishen, :xishen, :fushen, :suici, :yi, :ji, :eweek, :emonth, :week)
    end
end
