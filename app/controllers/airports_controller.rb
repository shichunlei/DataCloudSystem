class AirportsController < ApplicationController
  before_action :set_airport, only: [:show, :edit, :update, :destroy]

  # GET /airports
  def index
    @page = params[:page]
    @airports = Airport.order(:id).page(@page)
  end

  # GET /airports/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /airports/new
  def new
    @airport = Airport.new
  end

  # GET /airports/1/edit
  def edit
  end

  # POST /airports
  def create
    @airport = Airport.new(airport_params)

    if @airport.save
      redirect_to @airport, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /airports/1
  def update
    if @airport.update(airport_params)
      redirect_to @airport, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /airports/1
  def destroy
    @airport.destroy
    redirect_to airports_url, notice: "删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_airport
      @airport = Airport.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def airport_params
      params.require(:airport).permit(:name, :iata, :icao, :other_name, :country_id, :city_name, :intro)
    end
end
