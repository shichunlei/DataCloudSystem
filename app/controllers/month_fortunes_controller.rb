class MonthFortunesController < ApplicationController
  before_action :set_month_fortune, only: [:show, :edit, :update, :destroy]
  # GET /month_fortunes
  def index
    @page = params[:page]
    @month_fortunes = MonthFortune.order(:id).page(@page)
  end
  # GET /month_fortunes/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /month_fortunes/new
  def new
    @month_fortune = MonthFortune.new
  end

  # GET /month_fortunes/1/edit
  def edit
  end

  # POST /month_fortunes
  def create
    @month_fortune = MonthFortune.new(month_fortune_params)

    if @month_fortune.save
      redirect_to @month_fortune, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /month_fortunes/1
  def update
    if @month_fortune.update(month_fortune_params)
      redirect_to @month_fortune, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /month_fortunes/1
  def destroy
    @month_fortune.destroy
    redirect_to month_fortunes_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_month_fortune
      @month_fortune = MonthFortune.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def month_fortune_params
      params.require(:month_fortune).permit(:mdate, :summary, :money, :career, :love, :health, :astro_id)
    end
end
