class ShanhaijingsController < ApplicationController
  before_action :set_shanhaijing, only: [:show, :edit, :update, :destroy]
  # GET /shanhaijings
  def index
    @page = params[:page]
    @shanhaijings = Shanhaijing.order(:id).page(@page)
  end
  # GET /shanhaijings/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /shanhaijings/new
  def new
    @shanhaijing = Shanhaijing.new
  end

  # GET /shanhaijings/1/edit
  def edit
  end

  # POST /shanhaijings
  def create
    @shanhaijing = Shanhaijing.new(shanhaijing_params)

    if @shanhaijing.save
      redirect_to @shanhaijing, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /shanhaijings/1
  def update
    if @shanhaijing.update(shanhaijing_params)
      redirect_to @shanhaijing, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /shanhaijings/1
  def destroy
    @shanhaijing.destroy
    redirect_to shanhaijings_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shanhaijing
      @shanhaijing = Shanhaijing.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def shanhaijing_params
      params.require(:shanhaijing).permit(:name, :chapter, :content, :commentary, :appreciation, :translation, :interpretation)
    end
end
