class CarWheelsController < ApplicationController
  before_action :set_car_wheel, only: [:show, :edit, :update, :destroy]
  # GET /car_wheels
  def index
    @page = params[:page]
    @car_wheels = CarWheel.order(:id).page(@page)
  end
  # GET /car_wheels/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /car_wheels/new
  def new
    @car_wheel = CarWheel.new
  end

  # GET /car_wheels/1/edit
  def edit
  end

  # POST /car_wheels
  def create
    @car_wheel = CarWheel.new(car_wheel_params)

    if @car_wheel.save
      redirect_to @car_wheel, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /car_wheels/1
  def update
    if @car_wheel.update(car_wheel_params)
      redirect_to @car_wheel, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /car_wheels/1
  def destroy
    @car_wheel.destroy
    redirect_to car_wheels_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car_wheel
      @car_wheel = CarWheel.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def car_wheel_params
      params.require(:car_wheel).permit(:car_model_id, :fronttiresize, :reartiresize, :sparetiretype, :hubmaterial)
    end
end
