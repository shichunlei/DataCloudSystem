class HuangdineijingsController < ApplicationController
  before_action :set_huangdineijing, only: [:show, :edit, :update, :destroy]
  # GET /huangdineijings
  def index
    @page = params[:page]
    @huangdineijings = Huangdineijing.order(:id).page(@page)
  end
  # GET /huangdineijings/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /huangdineijings/new
  def new
    @huangdineijing = Huangdineijing.new
  end

  # GET /huangdineijings/1/edit
  def edit
  end

  # POST /huangdineijings
  def create
    @huangdineijing = Huangdineijing.new(huangdineijing_params)

    if @huangdineijing.save
      redirect_to @huangdineijing, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /huangdineijings/1
  def update
    if @huangdineijing.update(huangdineijing_params)
      redirect_to @huangdineijing, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /huangdineijings/1
  def destroy
    @huangdineijing.destroy
    redirect_to huangdineijings_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_huangdineijing
      @huangdineijing = Huangdineijing.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def huangdineijing_params
      params.require(:huangdineijing).permit(:name, :chapter, :content, :commentary, :appreciation, :translation, :interpretation)
    end
end
