class SnacksController < ApplicationController
  before_action :set_snack, only: [:show, :edit, :update, :destroy]

  # GET /snacks
  def index
    @page = params[:page]
    @snacks = Snack.order(:id).page(@page).per(20)
  end

  # GET /snacks/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /snacks/new
  def new
    @snack = Snack.new
  end

  # GET /snacks/1/edit
  def edit
  end

  # POST /snacks
  def create
    @snack = Snack.new(snack_params)

    if @snack.save
      redirect_to @snack, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /snacks/1
  def update
    if @snack.update(snack_params)
      redirect_to @snack, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /snacks/1
  def destroy
    @snack.destroy
    redirect_to snacks_url, notice: "删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_snack
      @snack = Snack.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def snack_params
      params.require(:snack).permit(:name, :intro, :history, :practice)
    end
end
