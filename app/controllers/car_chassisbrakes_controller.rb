class CarChassisbrakesController < ApplicationController
  before_action :set_car_chassisbrake, only: [:show, :edit, :update, :destroy]
  # GET /car_chassisbrakes
  def index
    @page = params[:page]
    @car_chassisbrakes = CarChassisbrake.order(:id).page(@page)
  end
  # GET /car_chassisbrakes/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /car_chassisbrakes/new
  def new
    @car_chassisbrake = CarChassisbrake.new
  end

  # GET /car_chassisbrakes/1/edit
  def edit
  end

  # POST /car_chassisbrakes
  def create
    @car_chassisbrake = CarChassisbrake.new(car_chassisbrake_params)

    if @car_chassisbrake.save
      redirect_to @car_chassisbrake, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /car_chassisbrakes/1
  def update
    if @car_chassisbrake.update(car_chassisbrake_params)
      redirect_to @car_chassisbrake, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /car_chassisbrakes/1
  def destroy
    @car_chassisbrake.destroy
    redirect_to car_chassisbrakes_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car_chassisbrake
      @car_chassisbrake = CarChassisbrake.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def car_chassisbrake_params
      params.require(:car_chassisbrake).permit(:car_model_id, :bodystructure, :powersteering, :frontbraketype, :rearbraketype, :parkingbraketype, :drivemode, :airsuspension, :adjustablesuspension, :frontsuspensiontype, :rearsuspensiontype, :centerdifferentiallock)
    end
end
