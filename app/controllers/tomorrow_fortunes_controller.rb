class TomorrowFortunesController < ApplicationController
  before_action :set_tomorrow_fortune, only: [:show, :edit, :update, :destroy]
  # GET /tomorrow_fortunes
  def index
    @page = params[:page]
    @tomorrow_fortunes = TomorrowFortune.order(:id).page(@page)
  end
  # GET /tomorrow_fortunes/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /tomorrow_fortunes/new
  def new
    @tomorrow_fortune = TomorrowFortune.new
  end

  # GET /tomorrow_fortunes/1/edit
  def edit
  end

  # POST /tomorrow_fortunes
  def create
    @tomorrow_fortune = TomorrowFortune.new(tomorrow_fortune_params)

    if @tomorrow_fortune.save
      redirect_to @tomorrow_fortune, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /tomorrow_fortunes/1
  def update
    if @tomorrow_fortune.update(tomorrow_fortune_params)
      redirect_to @tomorrow_fortune, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /tomorrow_fortunes/1
  def destroy
    @tomorrow_fortune.destroy
    redirect_to tomorrow_fortunes_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tomorrow_fortune
      @tomorrow_fortune = TomorrowFortune.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def tomorrow_fortune_params
      params.require(:tomorrow_fortune).permit(:tdate, :love, :health, :career, :color, :star, :number, :summary, :presummary, :money, :astro_id)
    end
end
