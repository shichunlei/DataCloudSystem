class CarLightsController < ApplicationController
  before_action :set_car_light, only: [:show, :edit, :update, :destroy]
  # GET /car_lights
  def index
    @page = params[:page]
    @car_lights = CarLight.order(:id).page(@page)
  end
  # GET /car_lights/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /car_lights/new
  def new
    @car_light = CarLight.new
  end

  # GET /car_lights/1/edit
  def edit
  end

  # POST /car_lights
  def create
    @car_light = CarLight.new(car_light_params)

    if @car_light.save
      redirect_to @car_light, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /car_lights/1
  def update
    if @car_light.update(car_light_params)
      redirect_to @car_light, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /car_lights/1
  def destroy
    @car_light.destroy
    redirect_to car_lights_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car_light
      @car_light = CarLight.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def car_light_params
      params.require(:car_light).permit(:car_model_id, :headlighttype, :optionalheadlighttype, :headlightautomaticopen, :headlightautomaticclean, :headlightdelayoff, :headlightdynamicsteering, :headlightilluminationadjustment, :headlightdimming, :frontfoglight, :readinglight, :interiorairlight, :daytimerunninglight, :ledtaillight, :lightsteeringassist)
    end
end
