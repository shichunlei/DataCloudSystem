class MengxibitansController < ApplicationController
  before_action :set_mengxibitan, only: [:show, :edit, :update, :destroy]
  # GET /mengxibitans
  def index
    @page = params[:page]
    @mengxibitans = Mengxibitan.order(:id).page(@page)
  end
  # GET /mengxibitans/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /mengxibitans/new
  def new
    @mengxibitan = Mengxibitan.new
  end

  # GET /mengxibitans/1/edit
  def edit
  end

  # POST /mengxibitans
  def create
    @mengxibitan = Mengxibitan.new(mengxibitan_params)

    if @mengxibitan.save
      redirect_to @mengxibitan, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /mengxibitans/1
  def update
    if @mengxibitan.update(mengxibitan_params)
      redirect_to @mengxibitan, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /mengxibitans/1
  def destroy
    @mengxibitan.destroy
    redirect_to mengxibitans_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mengxibitan
      @mengxibitan = Mengxibitan.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def mengxibitan_params
      params.require(:mengxibitan).permit(:name, :content, :commentary, :appreciation, :translation, :interpretation)
    end
end
