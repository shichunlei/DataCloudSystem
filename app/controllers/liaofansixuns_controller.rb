class LiaofansixunsController < ApplicationController
  before_action :set_liaofansixun, only: [:show, :edit, :update, :destroy]

  # GET /liaofansixuns
  def index
    @page = params[:page]
    @liaofansixuns = Liaofansixun.order(:id).page(@page)
  end

  # GET /liaofansixuns/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /liaofansixuns/new
  def new
    @liaofansixun = Liaofansixun.new
  end

  # GET /liaofansixuns/1/edit
  def edit
  end

  # POST /liaofansixuns
  def create
    @liaofansixun = Liaofansixun.new(liaofansixun_params)

    if @liaofansixun.save
      redirect_to @liaofansixun, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /liaofansixuns/1
  def update
    if @liaofansixun.update(liaofansixun_params)
      redirect_to @liaofansixun, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /liaofansixuns/1
  def destroy
    @liaofansixun.destroy
    redirect_to liaofansixuns_url, notice: "删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_liaofansixun
      @liaofansixun = Liaofansixun.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def liaofansixun_params
      params.require(:liaofansixun).permit(:name, :author, :chapter, :content, :commentary, :translation, :appreciation, :interpretation)
    end
end
