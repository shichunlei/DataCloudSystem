class WenyanwensController < ApplicationController
  before_action :set_wenyanwen, only: [:show, :edit, :update, :destroy]

  # GET /wenyanwens
  def index
    @page = params[:page]
    @wenyanwens = Wenyanwen.order(:id).page(@page)
  end

  # GET /wenyanwens/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /wenyanwens/new
  def new
    @wenyanwen = Wenyanwen.new
  end

  # GET /wenyanwens/1/edit
  def edit
  end

  # POST /wenyanwens
  def create
    @wenyanwen = Wenyanwen.new(wenyanwen_params)

    if @wenyanwen.save
      redirect_to @wenyanwen, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /wenyanwens/1
  def update
    if @wenyanwen.update(wenyanwen_params)
      redirect_to @wenyanwen, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /wenyanwens/1
  def destroy
    @wenyanwen.destroy
    redirect_to wenyanwens_url, notice: "删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wenyanwen
      @wenyanwen = Wenyanwen.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def wenyanwen_params
      params.require(:wenyanwen).permit(:name, :author, :content, :commentary, :translation, :appreciation, :interpretation, :background)
    end
end
