class CarBodiesController < ApplicationController
  before_action :set_car_body, only: [:show, :edit, :update, :destroy]
  # GET /car_bodies
  def index
    @page = params[:page]
    @car_bodies = CarBody.order(:id).page(@page)
  end
  # GET /car_bodies/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /car_bodies/new
  def new
    @car_body = CarBody.new
  end

  # GET /car_bodies/1/edit
  def edit
  end

  # POST /car_bodies
  def create
    @car_body = CarBody.new(car_body_params)

    if @car_body.save
      redirect_to @car_body, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /car_bodies/1
  def update
    if @car_body.update(car_body_params)
      redirect_to @car_body, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /car_bodies/1
  def destroy
    @car_body.destroy
    redirect_to car_bodies_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car_body
      @car_body = CarBody.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def car_body_params
      params.require(:car_body).permit(:car_model_id, :color, :len, :width, :height, :wheelbase, :fronttrack, :reartrack, :weight, :fullweight, :mingroundclearance, :approachangle, :departureangle, :luggagevolume, :luggagemode, :luggageopenmode, :inductionluggage, :doornum, :tooftype, :hoodtype, :roofluggagerack, :sportpackage)
    end
end
