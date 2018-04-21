class YearFortunesController < ApplicationController
  before_action :set_year_fortune, only: [:show, :edit, :update, :destroy]
  # GET /year_fortunes
  def index
    @page = params[:page]
    @year_fortunes = YearFortune.order("year desc, astro_id asc").page(@page)
  end
  # GET /year_fortunes/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /year_fortunes/new
  def new
    @year_fortune = YearFortune.new
  end

  # GET /year_fortunes/1/edit
  def edit
  end

  # POST /year_fortunes
  def create
    @year_fortune = YearFortune.new(year_fortune_params)

    if @year_fortune.save
      redirect_to @year_fortune, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /year_fortunes/1
  def update
    if @year_fortune.update(year_fortune_params)
      redirect_to @year_fortune, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /year_fortunes/1
  def destroy
    @year_fortune.destroy
    redirect_to year_fortunes_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_year_fortune
      @year_fortune = YearFortune.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def year_fortune_params
      params.require(:year_fortune).permit(:year, :summary, :money, :career, :love, :astro_id)
    end
end
