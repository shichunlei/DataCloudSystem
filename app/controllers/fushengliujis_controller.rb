class FushengliujisController < ApplicationController
  before_action :set_fushengliuji, only: [:show, :edit, :update, :destroy]

  # GET /fushengliujis
  def index
    @page = params[:page]
    @fushengliujis = Fushengliuji.order(:id).page(@page)
  end

  # GET /fushengliujis/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /fushengliujis/new
  def new
    @fushengliuji = Fushengliuji.new
  end

  # GET /fushengliujis/1/edit
  def edit
  end

  # POST /fushengliujis
  def create
    @fushengliuji = Fushengliuji.new(fushengliuji_params)

    if @fushengliuji.save
      redirect_to @fushengliuji, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /fushengliujis/1
  def update
    if @fushengliuji.update(fushengliuji_params)
      redirect_to @fushengliuji, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /fushengliujis/1
  def destroy
    @fushengliuji.destroy
    redirect_to fushengliujis_url, notice: "删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fushengliuji
      @fushengliuji = Fushengliuji.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def fushengliuji_params
      params.require(:fushengliuji).permit(:name, :author, :chapter, :content, :commentary, :translation, :appreciation, :interpretation)
    end
end
