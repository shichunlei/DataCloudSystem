class CountiesController < ApplicationController
  before_action :set_county, only: [:show, :edit, :update, :destroy]

  # GET /counties
  def index
    @page = params[:page]
    @counties = County.order(:id).page(@page).per(30)
  end

  # GET /counties/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /counties/new
  def new
    @county = County.new
  end

  # GET /counties/1/edit
  def edit
  end

  # POST /counties
  def create
    @county = County.new(county_params)

    if @county.save
      redirect_to @county, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /counties/1
  def update
    if @county.update(county_params)
      redirect_to @county, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /counties/1
  def destroy
    @county.destroy
    redirect_to counties_url, notice: "删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_county
      @county = County.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def county_params
      params.require(:county).permit(:name, :no, :city_id)
    end
end
