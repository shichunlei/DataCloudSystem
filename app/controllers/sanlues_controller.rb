class SanluesController < ApplicationController
  before_action :set_sanlue, only: [:show, :edit, :update, :destroy]

  # GET /sanlues
  def index
    @page = params[:page]
    @sanlues = Sanlue.order(:id).page(@page)
  end

  # GET /sanlues/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /sanlues/new
  def new
    @sanlue = Sanlue.new
  end

  # GET /sanlues/1/edit
  def edit
  end

  # POST /sanlues
  def create
    @sanlue = Sanlue.new(sanlue_params)

    if @sanlue.save
      redirect_to @sanlue, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /sanlues/1
  def update
    if @sanlue.update(sanlue_params)
      redirect_to @sanlue, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /sanlues/1
  def destroy
    @sanlue.destroy
    redirect_to sanlues_url, notice: "删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sanlue
      @sanlue = Sanlue.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def sanlue_params
      params.require(:sanlue).permit(:name, :author, :chapter, :content, :commentary, :translation, :appreciation, :interpretation)
    end
end
