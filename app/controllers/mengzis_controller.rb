class MengzisController < ApplicationController
  before_action :set_mengzi, only: [:show, :edit, :update, :destroy]
  # GET /mengzis
  def index
    @page = params[:page]
    @mengzis = Mengzi.order(:id).page(@page)
  end
  # GET /mengzis/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /mengzis/new
  def new
    @mengzi = Mengzi.new
  end

  # GET /mengzis/1/edit
  def edit
  end

  # POST /mengzis
  def create
    @mengzi = Mengzi.new(mengzi_params)

    if @mengzi.save
      redirect_to @mengzi, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /mengzis/1
  def update
    if @mengzi.update(mengzi_params)
      redirect_to @mengzi, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /mengzis/1
  def destroy
    @mengzi.destroy
    redirect_to mengzis_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mengzi
      @mengzi = Mengzi.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def mengzi_params
      params.require(:mengzi).permit(:chapter, :name, :content, :commentary, :translation, :appreciation, :interpretation)
    end
end
