class LunyusController < ApplicationController
  before_action :set_lunyu, only: [:show, :edit, :update, :destroy]
  # GET /lunyus
  def index
    @page = params[:page]
    @lunyus = Lunyu.order(:id).page(@page)
  end
  # GET /lunyus/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /lunyus/new
  def new
    @lunyu = Lunyu.new
  end

  # GET /lunyus/1/edit
  def edit
  end

  # POST /lunyus
  def create
    @lunyu = Lunyu.new(lunyu_params)

    if @lunyu.save
      redirect_to @lunyu, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /lunyus/1
  def update
    if @lunyu.update(lunyu_params)
      redirect_to @lunyu, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /lunyus/1
  def destroy
    @lunyu.destroy
    redirect_to lunyus_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lunyu
      @lunyu = Lunyu.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def lunyu_params
      params.require(:lunyu).permit(:chapter, :name, :content, :commentary, :translation, :appreciation, :interpretation)
    end
end
