class XuxiakesController < ApplicationController
  before_action :set_xuxiake, only: [:show, :edit, :update, :destroy]
  # GET /xuxiakes
  def index
    @page = params[:page]
    @xuxiakes = Xuxiake.order(:id).page(@page)
  end
  # GET /xuxiakes/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /xuxiakes/new
  def new
    @xuxiake = Xuxiake.new
  end

  # GET /xuxiakes/1/edit
  def edit
  end

  # POST /xuxiakes
  def create
    @xuxiake = Xuxiake.new(xuxiake_params)

    if @xuxiake.save
      redirect_to @xuxiake, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /xuxiakes/1
  def update
    if @xuxiake.update(xuxiake_params)
      redirect_to @xuxiake, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /xuxiakes/1
  def destroy
    @xuxiake.destroy
    redirect_to xuxiakes_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_xuxiake
      @xuxiake = Xuxiake.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def xuxiake_params
      params.require(:xuxiake).permit(:name, :content, :commentary, :appreciation, :translation, :interpretation)
    end
end
