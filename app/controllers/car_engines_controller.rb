class CarEnginesController < ApplicationController
  before_action :set_car_engine, only: [:show, :edit, :update, :destroy]
  # GET /car_engines
  def index
    @page = params[:page]
    @car_engines = CarEngine.order(:id).page(@page)
  end
  # GET /car_engines/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /car_engines/new
  def new
    @car_engine = CarEngine.new
  end

  # GET /car_engines/1/edit
  def edit
  end

  # POST /car_engines
  def create
    @car_engine = CarEngine.new(car_engine_params)

    if @car_engine.save
      redirect_to @car_engine, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /car_engines/1
  def update
    if @car_engine.update(car_engine_params)
      redirect_to @car_engine, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /car_engines/1
  def destroy
    @car_engine.destroy
    redirect_to car_engines_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car_engine
      @car_engine = CarEngine.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def car_engine_params
      params.require(:car_engine).permit(:car_model_id, :position, :model, :displacement, :displacementml, :intakeform, :cylinderarrangetype, :cylindernum, :valvetrain, :valvestructure, :compressionratio, :bore, :stroke, :maxhorsepower, :maxpower, :maxpowerspeed, :maxtorque, :maxtorquespeed, :fueltype, :fuelgrade, :fuelmethod, :fueltankcapacity, :cylinderheadmaterial, :cylinderbodymaterial, :environmentalstandards, :startstopsystem)
    end
end
