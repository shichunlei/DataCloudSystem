class ShishuoxinyusController < ApplicationController
  before_action :set_shishuoxinyu, only: [:show, :edit, :update, :destroy]
  # GET /shishuoxinyus
  def index
    @page = params[:page]
    @shishuoxinyus = Shishuoxinyu.order(:id).page(@page)
  end
  # GET /shishuoxinyus/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /shishuoxinyus/new
  def new
    @shishuoxinyu = Shishuoxinyu.new
  end

  # GET /shishuoxinyus/1/edit
  def edit
  end

  # POST /shishuoxinyus
  def create
    @shishuoxinyu = Shishuoxinyu.new(shishuoxinyu_params)

    if @shishuoxinyu.save
      redirect_to @shishuoxinyu, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /shishuoxinyus/1
  def update
    if @shishuoxinyu.update(shishuoxinyu_params)
      redirect_to @shishuoxinyu, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /shishuoxinyus/1
  def destroy
    @shishuoxinyu.destroy
    redirect_to shishuoxinyus_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shishuoxinyu
      @shishuoxinyu = Shishuoxinyu.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def shishuoxinyu_params
      params.require(:shishuoxinyu).permit(:name, :content, :commentary, :appreciation, :translation, :interpretation)
    end
end
