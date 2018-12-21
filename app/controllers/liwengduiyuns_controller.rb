class LiwengduiyunsController < ApplicationController
  before_action :set_liwengduiyun, only: [:show, :edit, :update, :destroy]

  # GET /liwengduiyuns
  def index
    @page = params[:page]
    @liwengduiyuns = Liwengduiyun.order(:id).page(@page)
  end

  # GET /liwengduiyuns/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /liwengduiyuns/new
  def new
    @liwengduiyun = Liwengduiyun.new
  end

  # GET /liwengduiyuns/1/edit
  def edit
  end

  # POST /liwengduiyuns
  def create
    @liwengduiyun = Liwengduiyun.new(liwengduiyun_params)

    if @liwengduiyun.save
      redirect_to @liwengduiyun, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /liwengduiyuns/1
  def update
    if @liwengduiyun.update(liwengduiyun_params)
      redirect_to @liwengduiyun, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /liwengduiyuns/1
  def destroy
    @liwengduiyun.destroy
    redirect_to liwengduiyuns_url, notice: "删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_liwengduiyun
      @liwengduiyun = Liwengduiyun.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def liwengduiyun_params
      params.require(:liwengduiyun).permit(:chapter, :name, :author, :content, :commentary, :translation, :appreciation, :interpretation)
    end
end
