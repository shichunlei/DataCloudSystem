class CarInternalconfigsController < ApplicationController
  before_action :set_car_internalconfig, only: [:show, :edit, :update, :destroy]
  # GET /car_internalconfigs
  def index
    @page = params[:page]
    @car_internalconfigs = CarInternalconfig.order(:id).page(@page)
  end
  # GET /car_internalconfigs/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /car_internalconfigs/new
  def new
    @car_internalconfig = CarInternalconfig.new
  end

  # GET /car_internalconfigs/1/edit
  def edit
  end

  # POST /car_internalconfigs
  def create
    @car_internalconfig = CarInternalconfig.new(car_internalconfig_params)

    if @car_internalconfig.save
      redirect_to @car_internalconfig, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /car_internalconfigs/1
  def update
    if @car_internalconfig.update(car_internalconfig_params)
      redirect_to @car_internalconfig, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /car_internalconfigs/1
  def destroy
    @car_internalconfig.destroy
    redirect_to car_internalconfigs_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car_internalconfig
      @car_internalconfig = CarInternalconfig.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def car_internalconfig_params
      params.require(:car_internalconfig).permit(:car_model_id, :steeringwheelbeforeadjustment, :steeringwheelupadjustment, :steeringwheeladjustmentmode, :steeringwheelmemory, :steeringwheelmaterial, :steeringwheelmultifunction, :steeringwheelheating, :computerscreen, :huddisplay, :interiorcolor, :rearcupholder, :supplyvoltage)
    end
end
