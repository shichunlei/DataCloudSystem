class HanshusController < ApplicationController
  before_action :set_hanshu, only: [:show, :edit, :update, :destroy]

  # GET /hanshus
  def index
    @page = params[:page]
    @hanshus = Hanshu.order(:id).page(@page)
  end

  # GET /hanshus/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /hanshus/new
  def new
    @hanshu = Hanshu.new
  end

  # GET /hanshus/1/edit
  def edit
  end

  # POST /hanshus
  def create
    @hanshu = Hanshu.new(hanshu_params)

    if @hanshu.save
      redirect_to @hanshu, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /hanshus/1
  def update
    if @hanshu.update(hanshu_params)
      redirect_to @hanshu, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /hanshus/1
  def destroy
    @hanshu.destroy
    redirect_to hanshus_url, notice: "删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hanshu
      @hanshu = Hanshu.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def hanshu_params
      params.require(:hanshu).permit(:name, :chapter, :author, :content, :commentary, :appreciation, :translation, :interpretation)
    end
end
