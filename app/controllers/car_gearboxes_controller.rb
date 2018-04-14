class CarGearboxesController < ApplicationController
  before_action :set_car_gearbox, only: [:show, :edit, :update, :destroy]
  # GET /car_gearboxes
  def index
    @page = params[:page]
    @car_gearboxes = CarGearbox.order(:id).page(@page)
  end
  # GET /car_gearboxes/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /car_gearboxes/new
  def new
    @car_gearbox = CarGearbox.new
  end

  # GET /car_gearboxes/1/edit
  def edit
  end

  # POST /car_gearboxes
  def create
    @car_gearbox = CarGearbox.new(car_gearbox_params)

    if @car_gearbox.save
      redirect_to @car_gearbox, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /car_gearboxes/1
  def update
    if @car_gearbox.update(car_gearbox_params)
      redirect_to @car_gearbox, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /car_gearboxes/1
  def destroy
    @car_gearbox.destroy
    redirect_to car_gearboxes_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car_gearbox
      @car_gearbox = CarGearbox.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def car_gearbox_params
      params.require(:car_gearbox).permit(:car_model_id, :gearbox, :shiftpaddles)
    end
end
