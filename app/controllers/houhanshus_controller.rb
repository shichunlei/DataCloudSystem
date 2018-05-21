class HouhanshusController < ApplicationController
  before_action :set_houhanshu, only: [:show, :edit, :update, :destroy]

  # GET /houhanshus
  def index
    @page = params[:page]
    @houhanshus = Houhanshu.order(:id).page(@page)
  end

  # GET /houhanshus/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /houhanshus/new
  def new
    @houhanshu = Houhanshu.new
  end

  # GET /houhanshus/1/edit
  def edit
  end

  # POST /houhanshus
  def create
    @houhanshu = Houhanshu.new(houhanshu_params)

    if @houhanshu.save
      redirect_to @houhanshu, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /houhanshus/1
  def update
    if @houhanshu.update(houhanshu_params)
      redirect_to @houhanshu, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /houhanshus/1
  def destroy
    @houhanshu.destroy
    redirect_to houhanshus_url, notice: "删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_houhanshu
      @houhanshu = Houhanshu.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def houhanshu_params
      params.require(:houhanshu).permit(:name, :chapter, :author, :content, :commentary, :appreciation, :translation, :interpretation)
    end
end
