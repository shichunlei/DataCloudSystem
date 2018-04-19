class WenxindiaolongsController < ApplicationController
  before_action :set_wenxindiaolong, only: [:show, :edit, :update, :destroy]
  # GET /wenxindiaolongs
  def index
    @page = params[:page]
    @wenxindiaolongs = Wenxindiaolong.order(:id).page(@page)
  end
  # GET /wenxindiaolongs/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /wenxindiaolongs/new
  def new
    @wenxindiaolong = Wenxindiaolong.new
  end

  # GET /wenxindiaolongs/1/edit
  def edit
  end

  # POST /wenxindiaolongs
  def create
    @wenxindiaolong = Wenxindiaolong.new(wenxindiaolong_params)

    if @wenxindiaolong.save
      redirect_to @wenxindiaolong, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /wenxindiaolongs/1
  def update
    if @wenxindiaolong.update(wenxindiaolong_params)
      redirect_to @wenxindiaolong, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /wenxindiaolongs/1
  def destroy
    @wenxindiaolong.destroy
    redirect_to wenxindiaolongs_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wenxindiaolong
      @wenxindiaolong = Wenxindiaolong.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def wenxindiaolong_params
      params.require(:wenxindiaolong).permit(:name, :content, :commentary, :appreciation, :translation, :interpretation)
    end
end
