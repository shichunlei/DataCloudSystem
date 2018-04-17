class TodayhistoriesController < ApplicationController
  before_action :set_todayhistory, only: [:show, :edit, :update, :destroy]
  # GET /todayhistories
  def index
    @page = params[:page]
    @todayhistories = Todayhistory.order(:id).page(@page)
  end
  # GET /todayhistories/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /todayhistories/new
  def new
    @todayhistory = Todayhistory.new
  end

  # GET /todayhistories/1/edit
  def edit
  end

  # POST /todayhistories
  def create
    @todayhistory = Todayhistory.new(todayhistory_params)

    if @todayhistory.save
      redirect_to @todayhistory, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /todayhistories/1
  def update
    if @todayhistory.update(todayhistory_params)
      redirect_to @todayhistory, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /todayhistories/1
  def destroy
    @todayhistory.destroy
    redirect_to todayhistories_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todayhistory
      @todayhistory = Todayhistory.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def todayhistory_params
      params.require(:todayhistory).permit(:name, :year, :month, :day, :image, :content)
    end
end
