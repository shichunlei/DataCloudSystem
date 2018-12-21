class XiaojingsController < ApplicationController
  before_action :set_xiaojing, only: [:show, :edit, :update, :destroy]

  # GET /xiaojings
  def index
    @page = params[:page]
    @xiaojings = Xiaojing.order(:id).page(@page)
  end

  # GET /xiaojings/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /xiaojings/new
  def new
    @xiaojing = Xiaojing.new
  end

  # GET /xiaojings/1/edit
  def edit
  end

  # POST /xiaojings
  def create
    @xiaojing = Xiaojing.new(xiaojing_params)

    if @xiaojing.save
      redirect_to @xiaojing, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /xiaojings/1
  def update
    if @xiaojing.update(xiaojing_params)
      redirect_to @xiaojing, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /xiaojings/1
  def destroy
    @xiaojing.destroy
    redirect_to xiaojings_url, notice: "删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_xiaojing
      @xiaojing = Xiaojing.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def xiaojing_params
      params.require(:xiaojing).permit(:name, :author, :content, :commentary, :translation, :appreciation, :interpretation)
    end
end
