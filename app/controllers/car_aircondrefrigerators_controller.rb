class CarAircondrefrigeratorsController < ApplicationController
  before_action :set_car_aircondrefrigerator, only: [:show, :edit, :update, :destroy]
  # GET /car_aircondrefrigerators
  def index
    @page = params[:page]
    @car_aircondrefrigerators = CarAircondrefrigerator.order(:id).page(@page)
  end
  # GET /car_aircondrefrigerators/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /car_aircondrefrigerators/new
  def new
    @car_aircondrefrigerator = CarAircondrefrigerator.new
  end

  # GET /car_aircondrefrigerators/1/edit
  def edit
  end

  # POST /car_aircondrefrigerators
  def create
    @car_aircondrefrigerator = CarAircondrefrigerator.new(car_aircondrefrigerator_params)

    if @car_aircondrefrigerator.save
      redirect_to @car_aircondrefrigerator, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /car_aircondrefrigerators/1
  def update
    if @car_aircondrefrigerator.update(car_aircondrefrigerator_params)
      redirect_to @car_aircondrefrigerator, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /car_aircondrefrigerators/1
  def destroy
    @car_aircondrefrigerator.destroy
    redirect_to car_aircondrefrigerators_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car_aircondrefrigerator
      @car_aircondrefrigerator = CarAircondrefrigerator.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def car_aircondrefrigerator_params
      params.require(:car_aircondrefrigerator).permit(:car_model_id, :airconditioningcontrolmode, :tempzonecontrol, :rearairconditioning, :reardischargeoutlet, :airconditioning, :airpurifyingdevice, :carrefrigerator)
    end
end
