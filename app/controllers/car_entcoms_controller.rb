class CarEntcomsController < ApplicationController
  before_action :set_car_entcom, only: [:show, :edit, :update, :destroy]
  # GET /car_entcoms
  def index
    @page = params[:page]
    @car_entcoms = CarEntcom.order(:id).page(@page)
  end
  # GET /car_entcoms/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /car_entcoms/new
  def new
    @car_entcom = CarEntcom.new
  end

  # GET /car_entcoms/1/edit
  def edit
  end

  # POST /car_entcoms
  def create
    @car_entcom = CarEntcom.new(car_entcom_params)

    if @car_entcom.save
      redirect_to @car_entcom, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /car_entcoms/1
  def update
    if @car_entcom.update(car_entcom_params)
      redirect_to @car_entcom, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /car_entcoms/1
  def destroy
    @car_entcom.destroy
    redirect_to car_entcoms_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car_entcom
      @car_entcom = CarEntcom.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def car_entcom_params
      params.require(:car_entcom).permit(:car_model_id, :locationservice, :bluetooth, :externalaudiointerface, :builtinharddisk, :cartv, :speakernum, :audiobrand, :dvd, :cd, :consolelcdscreen, :rearlcdscreen)
    end
end
