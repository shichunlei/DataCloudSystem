class DaxuesController < ApplicationController
  before_action :set_daxue, only: [:show, :edit, :update, :destroy]

  # GET /daxues
  def index
    @daxues = Daxue.order(:id)
  end

  # GET /daxues/1
  def show
  end

  # GET /daxues/new
  def new
    @daxue = Daxue.new
  end

  # GET /daxues/1/edit
  def edit
  end

  # POST /daxues
  def create
    @daxue = Daxue.new(daxue_params)

    if @daxue.save
      redirect_to @daxue, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /daxues/1
  def update
    if @daxue.update(daxue_params)
      redirect_to @daxue, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /daxues/1
  def destroy
    @daxue.destroy
    redirect_to daxues_url, notice: "删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_daxue
      @daxue = Daxue.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def daxue_params
      params.require(:daxue).permit(:name, :author, :content, :commentary, :translation, :appreciation, :interpretation)
    end
end
