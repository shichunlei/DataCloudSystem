class CarBasicsController < ApplicationController
  before_action :set_car_basic, only: [:show, :edit, :update, :destroy]
  # GET /car_basics
  def index
    @page = params[:page]
    @car_basics = CarBasic.order(:id).page(@page)
  end
  # GET /car_basics/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /car_basics/new
  def new
    @car_basic = CarBasic.new
  end

  # GET /car_basics/1/edit
  def edit
  end

  # POST /car_basics
  def create
    @car_basic = CarBasic.new(car_basic_params)

    if @car_basic.save
      redirect_to @car_basic, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /car_basics/1
  def update
    if @car_basic.update(car_basic_params)
      redirect_to @car_basic, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /car_basics/1
  def destroy
    @car_basic.destroy
    redirect_to car_basics_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car_basic
      @car_basic = CarBasic.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def car_basic_params
      params.require(:car_basic).permit(:price, :saleprice, :warrantypolicy, :vechiletax, :displacement, :gearbox, :comfuelconsumption, :userfuelconsumption, :officialaccelerationtime100, :maxspeed, :seatnum, :car_model_id)
    end
end
