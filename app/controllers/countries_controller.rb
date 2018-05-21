class CountriesController < ApplicationController
  before_action :set_country, only: [:show, :edit, :update, :destroy]

  # GET /countries
  def index
    @page = params[:page]
    @countries = Country.order("area asc, id desc").page(@page)
  end

  # GET /countries/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /countries/new
  def new
    @country = Country.new
  end

  # GET /countries/1/edit
  def edit
  end

  # POST /countries
  def create
    @country = Country.new(country_params)

    if @country.save
      redirect_to @country, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /countries/1
  def update
    if @country.update(country_params)
      redirect_to @country, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /countries/1
  def destroy
    @country.destroy
    redirect_to countries_url, notice: "删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_country
      @country = Country.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def country_params
      params.require(:country).permit(:name, :enname, :area, :info, :flag, :finfo, :emblem, :einfo, :anthems, :lyrics, :compose, :lrc, :otherlrc)
    end
end
