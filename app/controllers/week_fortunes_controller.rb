class WeekFortunesController < ApplicationController
  before_action :set_week_fortune, only: [:show, :edit, :update, :destroy]
  # GET /week_fortunes
  def index
    @page = params[:page]
    @week_fortunes = WeekFortune.order(:id).page(@page)
  end
  # GET /week_fortunes/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /week_fortunes/new
  def new
    @week_fortune = WeekFortune.new
  end

  # GET /week_fortunes/1/edit
  def edit
  end

  # POST /week_fortunes
  def create
    @week_fortune = WeekFortune.new(week_fortune_params)

    if @week_fortune.save
      redirect_to @week_fortune, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /week_fortunes/1
  def update
    if @week_fortune.update(week_fortune_params)
      redirect_to @week_fortune, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /week_fortunes/1
  def destroy
    @week_fortune.destroy
    redirect_to week_fortunes_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_week_fortune
      @week_fortune = WeekFortune.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def week_fortune_params
      params.require(:week_fortune).permit(:start_date, :end_date, :money, :career, :love, :health, :job, :astro_id)
    end
end
