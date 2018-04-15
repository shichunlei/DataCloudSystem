class CarSeatsController < ApplicationController
  before_action :set_car_seat, only: [:show, :edit, :update, :destroy]
  # GET /car_seats
  def index
    @page = params[:page]
    @car_seats = CarSeat.order(:id).page(@page)
  end
  # GET /car_seats/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /car_seats/new
  def new
    @car_seat = CarSeat.new
  end

  # GET /car_seats/1/edit
  def edit
  end

  # POST /car_seats
  def create
    @car_seat = CarSeat.new(car_seat_params)

    if @car_seat.save
      redirect_to @car_seat, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /car_seats/1
  def update
    if @car_seat.update(car_seat_params)
      redirect_to @car_seat, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /car_seats/1
  def destroy
    @car_seat.destroy
    redirect_to car_seats_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car_seat
      @car_seat = CarSeat.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def car_seat_params
      params.require(:car_seat).permit(:car_model_id, :sportseat, :seatmaterial, :seatheightadjustment, :driverseatadjustmentmode, :auxiliaryseatadjustmentmode, :driverseatlumbarsupportadjustment, :driverseatshouldersupportadjustment, :frontseatheadrestadjustment, :rearseatadjustmentmode, :rearseatreclineproportion, :rearseatangleadjustment, :frontseatcenterarmrest, :rearseatcenterarmrest, :seatventilation, :seatheating, :seatmassage, :electricseatmemory, :childseatfixdevice, :thirdrowseat)
    end
end
