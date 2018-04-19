class SunzibingfasController < ApplicationController
  before_action :set_sunzibingfa, only: [:show, :edit, :update, :destroy]
  # GET /sunzibingfas
  def index
    @page = params[:page]
    @sunzibingfas = Sunzibingfa.order(:id).page(@page)
  end
  # GET /sunzibingfas/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /sunzibingfas/new
  def new
    @sunzibingfa = Sunzibingfa.new
  end

  # GET /sunzibingfas/1/edit
  def edit
  end

  # POST /sunzibingfas
  def create
    @sunzibingfa = Sunzibingfa.new(sunzibingfa_params)

    if @sunzibingfa.save
      redirect_to @sunzibingfa, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /sunzibingfas/1
  def update
    if @sunzibingfa.update(sunzibingfa_params)
      redirect_to @sunzibingfa, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /sunzibingfas/1
  def destroy
    @sunzibingfa.destroy
    redirect_to sunzibingfas_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sunzibingfa
      @sunzibingfa = Sunzibingfa.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def sunzibingfa_params
      params.require(:sunzibingfa).permit(:name, :content, :commentary, :appreciation, :translation, :interpretation)
    end
end
