class ChucisController < ApplicationController
  before_action :set_chuci, only: [:show, :edit, :update, :destroy]
  # GET /chucis
  def index
    @page = params[:page]
    @chucis = Chuci.order(:id).page(@page)
  end
  # GET /chucis/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /chucis/new
  def new
    @chuci = Chuci.new
  end

  # GET /chucis/1/edit
  def edit
  end

  # POST /chucis
  def create
    @chuci = Chuci.new(chuci_params)

    if @chuci.save
      redirect_to @chuci, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /chucis/1
  def update
    if @chuci.update(chuci_params)
      redirect_to @chuci, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /chucis/1
  def destroy
    @chuci.destroy
    redirect_to chucis_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chuci
      @chuci = Chuci.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def chuci_params
      params.require(:chuci).permit(:name, :author, :chapter, :content, :commentary, :translation, :appreciation, :interpretation)
    end
end
