class YilisController < ApplicationController
  before_action :set_yili, only: [:show, :edit, :update, :destroy]

  # GET /yilis
  def index
    @page = params[:page]
    @yilis = Yili.order(:id).page(@page)
  end

  # GET /yilis/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /yilis/new
  def new
    @yili = Yili.new
  end

  # GET /yilis/1/edit
  def edit
  end

  # POST /yilis
  def create
    @yili = Yili.new(yili_params)

    if @yili.save
      redirect_to @yili, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /yilis/1
  def update
    if @yili.update(yili_params)
      redirect_to @yili, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /yilis/1
  def destroy
    @yili.destroy
    redirect_to yilis_url, notice: "删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_yili
      @yili = Yili.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def yili_params
      params.require(:yili).permit(:name, :author, :content, :commentary, :translation, :appreciation, :interpretation)
    end
end
