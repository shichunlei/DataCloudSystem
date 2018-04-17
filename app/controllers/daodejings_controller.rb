class DaodejingsController < ApplicationController
  before_action :set_daodejing, only: [:show, :edit, :update, :destroy]
  # GET /daodejings
  def index
    @page = params[:page]
    @daodejings = Daodejing.order(:id).page(@page)
  end
  # GET /daodejings/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /daodejings/new
  def new
    @daodejing = Daodejing.new
  end

  # GET /daodejings/1/edit
  def edit
  end

  # POST /daodejings
  def create
    @daodejing = Daodejing.new(daodejing_params)

    if @daodejing.save
      redirect_to @daodejing, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /daodejings/1
  def update
    if @daodejing.update(daodejing_params)
      redirect_to @daodejing, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /daodejings/1
  def destroy
    @daodejing.destroy
    redirect_to daodejings_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_daodejing
      @daodejing = Daodejing.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def daodejing_params
      params.require(:daodejing).permit(:name, :content, :commentary, :translation, :appreciation, :interpretation)
    end
end
