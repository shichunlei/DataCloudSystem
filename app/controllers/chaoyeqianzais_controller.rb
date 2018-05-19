class ChaoyeqianzaisController < ApplicationController
  before_action :set_chaoyeqianzai, only: [:show, :edit, :update, :destroy]

  # GET /chaoyeqianzais
  def index
    @page = params[:page]
    @chaoyeqianzais = Chaoyeqianzai.order(:id).page(@page)
  end

  # GET /chaoyeqianzais/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /chaoyeqianzais/new
  def new
    @chaoyeqianzai = Chaoyeqianzai.new
  end

  # GET /chaoyeqianzais/1/edit
  def edit
  end

  # POST /chaoyeqianzais
  def create
    @chaoyeqianzai = Chaoyeqianzai.new(chaoyeqianzai_params)

    if @chaoyeqianzai.save
      redirect_to @chaoyeqianzai, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /chaoyeqianzais/1
  def update
    if @chaoyeqianzai.update(chaoyeqianzai_params)
      redirect_to @chaoyeqianzai, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /chaoyeqianzais/1
  def destroy
    @chaoyeqianzai.destroy
    redirect_to chaoyeqianzais_url, notice: "删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chaoyeqianzai
      @chaoyeqianzai = Chaoyeqianzai.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def chaoyeqianzai_params
      params.require(:chaoyeqianzai).permit(:name, :author, :chapter, :content, :commentary, :translation, :appreciation, :interpretation)
    end
end
