class CarDrivingauxiliariesController < ApplicationController
  before_action :set_car_drivingauxiliary, only: [:show, :edit, :update, :destroy]
  # GET /car_drivingauxiliaries
  def index
    @page = params[:page]
    @car_drivingauxiliaries = CarDrivingauxiliary.order(:id).page(@page)
  end
  # GET /car_drivingauxiliaries/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /car_drivingauxiliaries/new
  def new
    @car_drivingauxiliary = CarDrivingauxiliary.new
  end

  # GET /car_drivingauxiliaries/1/edit
  def edit
  end

  # POST /car_drivingauxiliaries
  def create
    @car_drivingauxiliary = CarDrivingauxiliary.new(car_drivingauxiliary_params)

    if @car_drivingauxiliary.save
      redirect_to @car_drivingauxiliary, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /car_drivingauxiliaries/1
  def update
    if @car_drivingauxiliary.update(car_drivingauxiliary_params)
      redirect_to @car_drivingauxiliary, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /car_drivingauxiliaries/1
  def destroy
    @car_drivingauxiliary.destroy
    redirect_to car_drivingauxiliaries_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car_drivingauxiliary
      @car_drivingauxiliary = CarDrivingauxiliary.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def car_drivingauxiliary_params
      params.require(:car_drivingauxiliary).permit(:car_model_id, :abs, :ebd, :brakeassist, :tractioncontrol, :esp, :eps, :automaticparking, :hillstartassist, :hilldescent, :frontparkingradar, :reversingradar, :reverseimage, :panoramiccamera, :cruisecontrol, :adaptivecruise, :gps, :automaticparkingintoplace, :ldws, :activebraking, :integralactivesteering, :nightvisionsystem, :blindspotdetection)
    end
end
