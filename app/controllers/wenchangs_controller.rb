class WenchangsController < ApplicationController
  before_action :set_wenchang, only: [:show, :edit, :update, :destroy]

  # GET /wenchangs
  def index
    @page = params[:page]
    @wenchangs = Wenchang.order(:id).page(@page)
  end

  # GET /wenchangs/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /wenchangs/new
  def new
    @wenchang = Wenchang.new
  end

  # GET /wenchangs/1/edit
  def edit
  end

  # POST /wenchangs
  def create
    @wenchang = Wenchang.new(wenchang_params)

    if @wenchang.save
      redirect_to @wenchang, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /wenchangs/1
  def update
    if @wenchang.update(wenchang_params)
      redirect_to @wenchang, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /wenchangs/1
  def destroy
    @wenchang.destroy
    redirect_to wenchangs_url, notice: "删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wenchang
      @wenchang = Wenchang.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def wenchang_params
      params.require(:wenchang).permit(:name, :author, :content, :commentary, :translation, :appreciation, :interpretation)
    end
end
