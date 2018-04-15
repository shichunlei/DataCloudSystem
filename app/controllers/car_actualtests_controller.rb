class CarActualtestsController < ApplicationController
  before_action :set_car_actualtest, only: [:show, :edit, :update, :destroy]
  # GET /car_actualtests
  def index
    @page = params[:page]
    @car_actualtests = CarActualtest.order(:id).page(@page)
  end
  # GET /car_actualtests/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /car_actualtests/new
  def new
    @car_actualtest = CarActualtest.new
  end

  # GET /car_actualtests/1/edit
  def edit
  end

  # POST /car_actualtests
  def create
    @car_actualtest = CarActualtest.new(car_actualtest_params)

    if @car_actualtest.save
      redirect_to @car_actualtest, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /car_actualtests/1
  def update
    if @car_actualtest.update(car_actualtest_params)
      redirect_to @car_actualtest, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /car_actualtests/1
  def destroy
    @car_actualtest.destroy
    redirect_to car_actualtests_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car_actualtest
      @car_actualtest = CarActualtest.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def car_actualtest_params
      params.require(:car_actualtest).permit(:car_model_id, :accelerationtime100, :brakingdistance)
    end
end
