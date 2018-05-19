class DiziguisController < ApplicationController
  before_action :set_dizigui, only: [:show, :edit, :update, :destroy]

  # GET /diziguis
  def index
    @page = params[:page]
    @diziguis = Dizigui.order(:id).page(@page)
  end

  # GET /diziguis/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /diziguis/new
  def new
    @dizigui = Dizigui.new
  end

  # GET /diziguis/1/edit
  def edit
  end

  # POST /diziguis
  def create
    @dizigui = Dizigui.new(dizigui_params)

    if @dizigui.save
      redirect_to @dizigui, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /diziguis/1
  def update
    if @dizigui.update(dizigui_params)
      redirect_to @dizigui, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /diziguis/1
  def destroy
    @dizigui.destroy
    redirect_to diziguis_url, notice: "删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dizigui
      @dizigui = Dizigui.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def dizigui_params
      params.require(:dizigui).permit(:name, :author, :chapter, :content, :commentary, :translation, :appreciation, :interpretation)
    end
end
