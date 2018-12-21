class XiaolinsController < ApplicationController
  before_action :set_xiaolin, only: [:show, :edit, :update, :destroy]

  # GET /xiaolins
  def index
    @page = params[:page]
    @xiaolins = Xiaolin.order(:id).page(@page).per(20)
  end

  # GET /xiaolins/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /xiaolins/new
  def new
    @xiaolin = Xiaolin.new
  end

  # GET /xiaolins/1/edit
  def edit
  end

  # POST /xiaolins
  def create
    @xiaolin = Xiaolin.new(xiaolin_params)

    if @xiaolin.save
      redirect_to @xiaolin, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /xiaolins/1
  def update
    if @xiaolin.update(xiaolin_params)
      redirect_to @xiaolin, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /xiaolins/1
  def destroy
    @xiaolin.destroy
    redirect_to xiaolins_url, notice: "删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_xiaolin
      @xiaolin = Xiaolin.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def xiaolin_params
      params.require(:xiaolin).permit(:name, :content, :commentary, :translation, :appreciation, :interpretation)
    end
end
