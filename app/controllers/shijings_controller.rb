class ShijingsController < ApplicationController
  before_action :set_shijing, only: [:show, :edit, :update, :destroy]
  # GET /shijings
  def index
    @page = params[:page]
    @shijings = Shijing.order(:id).page(@page)
  end
  # GET /shijings/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /shijings/new
  def new
    @shijing = Shijing.new
  end

  # GET /shijings/1/edit
  def edit
  end

  # POST /shijings
  def create
    @shijing = Shijing.new(shijing_params)

    if @shijing.save
      redirect_to @shijing, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /shijings/1
  def update
    if @shijing.update(shijing_params)
      redirect_to @shijing, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /shijings/1
  def destroy
    @shijing.destroy
    redirect_to shijings_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shijing
      @shijing = Shijing.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def shijing_params
      params.require(:shijing).permit(:name, :chapter, :content, :commentary, :appreciation, :translation, :interpretation)
    end
end
