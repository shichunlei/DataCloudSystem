class TiangongsController < ApplicationController
  before_action :set_tiangong, only: [:show, :edit, :update, :destroy]
  # GET /tiangongs
  def index
    @page = params[:page]
    @tiangongs = Tiangong.order(:id).page(@page)
  end
  # GET /tiangongs/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /tiangongs/new
  def new
    @tiangong = Tiangong.new
  end

  # GET /tiangongs/1/edit
  def edit
  end

  # POST /tiangongs
  def create
    @tiangong = Tiangong.new(tiangong_params)

    if @tiangong.save
      redirect_to @tiangong, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /tiangongs/1
  def update
    if @tiangong.update(tiangong_params)
      redirect_to @tiangong, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /tiangongs/1
  def destroy
    @tiangong.destroy
    redirect_to tiangongs_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tiangong
      @tiangong = Tiangong.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def tiangong_params
      params.require(:tiangong).permit(:name, :chapter, :content, :commentary, :appreciation, :translation, :interpretation)
    end
end
