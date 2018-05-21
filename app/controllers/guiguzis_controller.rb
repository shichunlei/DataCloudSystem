class GuiguzisController < ApplicationController
  before_action :set_guiguzi, only: [:show, :edit, :update, :destroy]

  # GET /guiguzis
  def index
    @page = params[:page]
    @guiguzis = Guiguzi.order(:id).page(@page)
  end

  # GET /guiguzis/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /guiguzis/new
  def new
    @guiguzi = Guiguzi.new
  end

  # GET /guiguzis/1/edit
  def edit
  end

  # POST /guiguzis
  def create
    @guiguzi = Guiguzi.new(guiguzi_params)

    if @guiguzi.save
      redirect_to @guiguzi, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /guiguzis/1
  def update
    if @guiguzi.update(guiguzi_params)
      redirect_to @guiguzi, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /guiguzis/1
  def destroy
    @guiguzi.destroy
    redirect_to guiguzis_url, notice: "删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_guiguzi
      @guiguzi = Guiguzi.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def guiguzi_params
      params.require(:guiguzi).permit(:name, :chapter, :author, :content, :commentary, :appreciation, :translation, :interpretation)
    end
end
