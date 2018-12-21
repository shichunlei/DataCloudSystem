class BencaosController < ApplicationController
  before_action :set_bencao, only: [:show, :edit, :update, :destroy]

  # GET /bencaos
  def index
    @page = params[:page]
    @bencaos = Bencao.order(:id).page(@page).per(30)
  end

  # GET /bencaos/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /bencaos/new
  def new
    @bencao = Bencao.new
  end

  # GET /bencaos/1/edit
  def edit
  end

  # POST /bencaos
  def create
    @bencao = Bencao.new(bencao_params)

    if @bencao.save
      redirect_to @bencao, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /bencaos/1
  def update
    if @bencao.update(bencao_params)
      redirect_to @bencao, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /bencaos/1
  def destroy
    @bencao.destroy
    redirect_to bencaos_url, notice: "删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bencao
      @bencao = Bencao.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def bencao_params
      params.require(:bencao).permit(:chapter, :name, :author, :content, :commentary, :translation, :appreciation, :interpretation)
    end
end
