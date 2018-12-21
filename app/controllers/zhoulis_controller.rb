class ZhoulisController < ApplicationController
  before_action :set_zhouli, only: [:show, :edit, :update, :destroy]

  # GET /zhoulis
  def index
    @page = params[:page]
    @zhoulis = Zhouli.order(:id).page(@page)
  end

  # GET /zhoulis/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /zhoulis/new
  def new
    @zhouli = Zhouli.new
  end

  # GET /zhoulis/1/edit
  def edit
  end

  # POST /zhoulis
  def create
    @zhouli = Zhouli.new(zhouli_params)

    if @zhouli.save
      redirect_to @zhouli, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /zhoulis/1
  def update
    if @zhouli.update(zhouli_params)
      redirect_to @zhouli, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /zhoulis/1
  def destroy
    @zhouli.destroy
    redirect_to zhoulis_url, notice: "删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_zhouli
      @zhouli = Zhouli.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def zhouli_params
      params.require(:zhouli).permit(:chapter, :name, :author, :content, :commentary, :translation, :appreciation, :interpretation)
    end
end
