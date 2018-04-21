class TodayFortunesController < ApplicationController
  before_action :set_today_fortune, only: [:show, :edit, :update, :destroy]
  # GET /today_fortunes
  def index
    @page = params[:page]
    @today_fortunes = TodayFortune.order("tdate desc, astro_id asc").page(@page)
  end
  # GET /today_fortunes/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /today_fortunes/new
  def new
    @today_fortune = TodayFortune.new
  end

  # GET /today_fortunes/1/edit
  def edit
  end

  # POST /today_fortunes
  def create
    @today_fortune = TodayFortune.new(today_fortune_params)

    if @today_fortune.save
      redirect_to @today_fortune, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /today_fortunes/1
  def update
    if @today_fortune.update(today_fortune_params)
      redirect_to @today_fortune, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /today_fortunes/1
  def destroy
    @today_fortune.destroy
    redirect_to today_fortunes_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_today_fortune
      @today_fortune = TodayFortune.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def today_fortune_params
      params.require(:today_fortune).permit(:tdate, :love, :health, :career, :color, :star, :number, :summary, :presummary, :money, :astro_id)
    end
end
