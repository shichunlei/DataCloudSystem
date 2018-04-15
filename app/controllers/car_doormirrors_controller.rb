class CarDoormirrorsController < ApplicationController
  before_action :set_car_doormirror, only: [:show, :edit, :update, :destroy]
  # GET /car_doormirrors
  def index
    @page = params[:page]
    @car_doormirrors = CarDoormirror.order(:id).page(@page)
  end
  # GET /car_doormirrors/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /car_doormirrors/new
  def new
    @car_doormirror = CarDoormirror.new
  end

  # GET /car_doormirrors/1/edit
  def edit
  end

  # POST /car_doormirrors
  def create
    @car_doormirror = CarDoormirror.new(car_doormirror_params)

    if @car_doormirror.save
      redirect_to @car_doormirror, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /car_doormirrors/1
  def update
    if @car_doormirror.update(car_doormirror_params)
      redirect_to @car_doormirror, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /car_doormirrors/1
  def destroy
    @car_doormirror.destroy
    redirect_to car_doormirrors_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car_doormirror
      @car_doormirror = CarDoormirror.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def car_doormirror_params
      params.require(:car_doormirror).permit(:car_model_id, :openstyle, :electricwindow, :uvinterceptingglass, :privacyglass, :antipinchwindow, :skylightopeningmode, :skylightstype, :rearwindowsunshade, :rearsidesunshade, :rearwiper, :sensingwiper, :electricpulldoor, :rearmirrorwithturnlamp, :externalmirrormemory, :externalmirrorheating, :externalmirrorfolding, :externalmirroradjustment, :rearviewmirrorantiglare, :sunvisormirror)
    end
end
