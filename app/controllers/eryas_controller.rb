class EryasController < ApplicationController
  before_action :set_erya, only: [:show, :edit, :update, :destroy]

  # GET /eryas
  def index
    @page = params[:page]
    @eryas = Erya.order(:id).page(@page)
  end

  # GET /eryas/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /eryas/new
  def new
    @erya = Erya.new
  end

  # GET /eryas/1/edit
  def edit
  end

  # POST /eryas
  def create
    @erya = Erya.new(erya_params)

    if @erya.save
      redirect_to @erya, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /eryas/1
  def update
    if @erya.update(erya_params)
      redirect_to @erya, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /eryas/1
  def destroy
    @erya.destroy
    redirect_to eryas_url, notice: "删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_erya
      @erya = Erya.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def erya_params
      params.require(:erya).permit(:name, :author, :content, :commentary, :translation, :appreciation, :interpretation)
    end
end
