class ZhongyongsController < ApplicationController
  before_action :set_zhongyong, only: [:show, :edit, :update, :destroy]

  # GET /zhongyongs
  def index
    @page = params[:page]
    @zhongyongs = Zhongyong.order(:id).page(@page)
  end

  # GET /zhongyongs/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /zhongyongs/new
  def new
    @zhongyong = Zhongyong.new
  end

  # GET /zhongyongs/1/edit
  def edit
  end

  # POST /zhongyongs
  def create
    @zhongyong = Zhongyong.new(zhongyong_params)

    if @zhongyong.save
      redirect_to @zhongyong, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /zhongyongs/1
  def update
    if @zhongyong.update(zhongyong_params)
      redirect_to @zhongyong, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /zhongyongs/1
  def destroy
    @zhongyong.destroy
    redirect_to zhongyongs_url, notice: "删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_zhongyong
      @zhongyong = Zhongyong.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def zhongyong_params
      params.require(:zhongyong).permit(:name, :author, :content, :commentary, :translation, :appreciation, :interpretation)
    end
end
