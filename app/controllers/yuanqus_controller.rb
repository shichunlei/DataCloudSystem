class YuanqusController < ApplicationController
  before_action :set_yuanqu, only: [:show, :edit, :update, :destroy]
  # GET /yuanqus
  def index
    @page = params[:page]
    @yuanqus = Yuanqu.order(:id).page(@page).per(30)
  end
  # GET /yuanqus/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /yuanqus/new
  def new
    @yuanqu = Yuanqu.new
  end

  # GET /yuanqus/1/edit
  def edit
  end

  # POST /yuanqus
  def create
    @yuanqu = Yuanqu.new(yuanqu_params)

    if @yuanqu.save
      redirect_to @yuanqu, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /yuanqus/1
  def update
    if @yuanqu.update(yuanqu_params)
      redirect_to @yuanqu, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /yuanqus/1
  def destroy
    @yuanqu.destroy
    redirect_to yuanqus_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_yuanqu
      @yuanqu = Yuanqu.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def yuanqu_params
      params.require(:yuanqu).permit(:name, :author, :content, :explanation, :appreciation)
    end
end
