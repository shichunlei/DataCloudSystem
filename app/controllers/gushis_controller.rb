class GushisController < ApplicationController
  before_action :set_gushi, only: [:show, :edit, :update, :destroy]

  # GET /gushis
  def index
    @page = params[:page]
    @gushis = Gushi.order(:id).page(@page)
  end

  # GET /gushis/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /gushis/new
  def new
    @gushi = Gushi.new
  end

  # GET /gushis/1/edit
  def edit
  end

  # POST /gushis
  def create
    @gushi = Gushi.new(gushi_params)

    if @gushi.save
      redirect_to @gushi, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /gushis/1
  def update
    if @gushi.update(gushi_params)
      redirect_to @gushi, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /gushis/1
  def destroy
    @gushi.destroy
    redirect_to gushis_url, notice: "删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gushi
      @gushi = Gushi.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def gushi_params
      params.require(:gushi).permit(:name, :author, :mtype, :content, :translation, :explanation, :appreciation)
    end
end
