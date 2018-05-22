class LawsController < ApplicationController
  before_action :set_law, only: [:show, :edit, :update, :destroy]

  # GET /laws
  def index
    @page = params[:page]
    @laws = Law.order("pub_date desc").page(@page).per(20)
  end

  # GET /laws/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /laws/new
  def new
    @law = Law.new
  end

  # GET /laws/1/edit
  def edit
  end

  # POST /laws
  def create
    @law = Law.new(law_params)

    if @law.save
      redirect_to @law, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /laws/1
  def update
    if @law.update(law_params)
      redirect_to @law, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /laws/1
  def destroy
    @law.destroy
    redirect_to laws_url, notice: "删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_law
      @law = Law.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def law_params
      params.require(:law).permit(:name, :pub_department, :reference_num, :pub_date, :exec_date, :pub_timeliness, :effectiveness_level, :regcategory, :content)
    end
end
