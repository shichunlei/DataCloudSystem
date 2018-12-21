class JingangjingsController < ApplicationController
  before_action :set_jingangjing, only: [:show, :edit, :update, :destroy]

  # GET /jingangjings
  def index
    @page = params[:page]
    @jingangjings = Jingangjing.order(:id).page(@page)
  end

  # GET /jingangjings/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /jingangjings/new
  def new
    @jingangjing = Jingangjing.new
  end

  # GET /jingangjings/1/edit
  def edit
  end

  # POST /jingangjings
  def create
    @jingangjing = Jingangjing.new(jingangjing_params)

    if @jingangjing.save
      redirect_to @jingangjing, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /jingangjings/1
  def update
    if @jingangjing.update(jingangjing_params)
      redirect_to @jingangjing, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /jingangjings/1
  def destroy
    @jingangjing.destroy
    redirect_to jingangjings_url, notice: "删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_jingangjing
      @jingangjing = Jingangjing.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def jingangjing_params
      params.require(:jingangjing).permit(:name, :content, :commentary, :translation, :appreciation, :interpretation)
    end
end
