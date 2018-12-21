class ZizhitongjiansController < ApplicationController
  before_action :set_zizhitongjian, only: [:show, :edit, :update, :destroy]

  # GET /zizhitongjians
  def index
    @page = params[:page]
    @zizhitongjians = Zizhitongjian.order(:id).page(@page).per(30)
  end

  # GET /zizhitongjians/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /zizhitongjians/new
  def new
    @zizhitongjian = Zizhitongjian.new
  end

  # GET /zizhitongjians/1/edit
  def edit
  end

  # POST /zizhitongjians
  def create
    @zizhitongjian = Zizhitongjian.new(zizhitongjian_params)

    if @zizhitongjian.save
      redirect_to @zizhitongjian, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /zizhitongjians/1
  def update
    if @zizhitongjian.update(zizhitongjian_params)
      redirect_to @zizhitongjian, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /zizhitongjians/1
  def destroy
    @zizhitongjian.destroy
    redirect_to zizhitongjians_url, notice: "删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_zizhitongjian
      @zizhitongjian = Zizhitongjian.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def zizhitongjian_params
      params.require(:zizhitongjian).permit(:chapter, :name, :author, :content, :commentary, :translation, :appreciation, :interpretation)
    end
end
