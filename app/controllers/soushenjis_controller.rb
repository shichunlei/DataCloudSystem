class SoushenjisController < ApplicationController
  before_action :set_soushenji, only: [:show, :edit, :update, :destroy]
  # GET /soushenjis
  def index
    @page = params[:page]
    @soushenjis = Soushenji.order(:id).page(@page)
  end
  # GET /soushenjis/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /soushenjis/new
  def new
    @soushenji = Soushenji.new
  end

  # GET /soushenjis/1/edit
  def edit
  end

  # POST /soushenjis
  def create
    @soushenji = Soushenji.new(soushenji_params)

    if @soushenji.save
      redirect_to @soushenji, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /soushenjis/1
  def update
    if @soushenji.update(soushenji_params)
      redirect_to @soushenji, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /soushenjis/1
  def destroy
    @soushenji.destroy
    redirect_to soushenjis_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_soushenji
      @soushenji = Soushenji.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def soushenji_params
      params.require(:soushenji).permit(:name, :content, :commentary, :appreciation, :translation, :interpretation)
    end
end
