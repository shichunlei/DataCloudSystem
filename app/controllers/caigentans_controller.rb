class CaigentansController < ApplicationController
  before_action :set_caigentan, only: [:show, :edit, :update, :destroy]

  # GET /caigentans
  def index
    @page = params[:page]
    @caigentans = Caigentan.order(:id).page(@page)
  end

  # GET /caigentans/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /caigentans/new
  def new
    @caigentan = Caigentan.new
  end

  # GET /caigentans/1/edit
  def edit
  end

  # POST /caigentans
  def create
    @caigentan = Caigentan.new(caigentan_params)

    if @caigentan.save
      redirect_to @caigentan, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /caigentans/1
  def update
    if @caigentan.update(caigentan_params)
      redirect_to @caigentan, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /caigentans/1
  def destroy
    @caigentan.destroy
    redirect_to caigentans_url, notice: "删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_caigentan
      @caigentan = Caigentan.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def caigentan_params
      params.require(:caigentan).permit(:name, :author, :chapter, :content, :commentary, :translation, :appreciation, :interpretation)
    end
end
