class AstrosController < ApplicationController
  before_action :set_astro, only: [:show, :edit, :update, :destroy]
  # GET /astros
  def index
    @page = params[:page]
    @astros = Astro.order(:id).page(@page)
  end
  # GET /astros/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /astros/new
  def new
    @astro = Astro.new
  end

  # GET /astros/1/edit
  def edit
  end

  # POST /astros
  def create
    @astro = Astro.new(astro_params)

    if @astro.save
      redirect_to @astro, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /astros/1
  def update
    if @astro.update(astro_params)
      redirect_to @astro, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /astros/1
  def destroy
    @astro.destroy
    redirect_to astros_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_astro
      @astro = Astro.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def astro_params
      params.require(:astro).permit(:name, :pic, :start_date, :end_date)
    end
end
