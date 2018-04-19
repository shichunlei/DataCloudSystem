class GuwensController < ApplicationController
  before_action :set_guwen, only: [:show, :edit, :update, :destroy]
  # GET /guwens
  def index
    @page = params[:page]
    @guwens = Guwen.order(:id).page(@page)
  end
  # GET /guwens/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /guwens/new
  def new
    @guwen = Guwen.new
  end

  # GET /guwens/1/edit
  def edit
  end

  # POST /guwens
  def create
    @guwen = Guwen.new(guwen_params)

    if @guwen.save
      redirect_to @guwen, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /guwens/1
  def update
    if @guwen.update(guwen_params)
      redirect_to @guwen, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /guwens/1
  def destroy
    @guwen.destroy
    redirect_to guwens_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_guwen
      @guwen = Guwen.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def guwen_params
      params.require(:guwen).permit(:name, :chapter, :content, :commentary, :appreciation, :translation, :interpretation)
    end
end
