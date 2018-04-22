class SanzijingsController < ApplicationController
  before_action :set_sanzijing, only: [:show, :edit, :update, :destroy]

  # GET /sanzijings
  def index
    @page = params[:page]
    @sanzijings = Sanzijing.order(:id).page(@page)
  end

  # GET /sanzijings/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /sanzijings/new
  def new
    @sanzijing = Sanzijing.new
  end

  # GET /sanzijings/1/edit
  def edit
  end

  # POST /sanzijings
  def create
    @sanzijing = Sanzijing.new(sanzijing_params)

    if @sanzijing.save
      redirect_to @sanzijing, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /sanzijings/1
  def update
    if @sanzijing.update(sanzijing_params)
      redirect_to @sanzijing, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /sanzijings/1
  def destroy
    @sanzijing.destroy
    redirect_to sanzijings_url, notice: "删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sanzijing
      @sanzijing = Sanzijing.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def sanzijing_params
      params.require(:sanzijing).permit(:name, :author, :content, :commentary, :translation, :appreciation, :interpretation)
    end
end
