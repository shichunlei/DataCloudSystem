class CarSavesController < ApplicationController
  before_action :set_car_safe, only: [:show, :edit, :update, :destroy]
  # GET /car_saves
  def index
    @page = params[:page]
    @car_saves = CarSafe.order(:id).page(@page)
  end
  # GET /car_saves/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /car_saves/new
  def new
    @car_safe = CarSafe.new
  end

  # GET /car_saves/1/edit
  def edit
  end

  # POST /car_saves
  def create
    @car_safe = CarSafe.new(car_safe_params)

    if @car_safe.save
      redirect_to @car_safe, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /car_saves/1
  def update
    if @car_safe.update(car_safe_params)
      redirect_to @car_safe, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /car_saves/1
  def destroy
    @car_safe.destroy
    redirect_to car_saves_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car_safe
      @car_safe = CarSafe.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def car_safe_params
      params.require(:car_safe).permit(:car_model_id, :airbagdrivingposition, :airbagfrontpassenger, :airbagfrontside, :airbagfronthead, :airbagknee, :airbagrearside, :airbagrearhead, :safetybeltprompt, :safetybeltlimiting, :safetybeltpretightening, :frontsafetybeltadjustment, :rearsafetybelt, :tirepressuremonitoring, :zeropressurecontinued, :centrallocking, :childlock, :remotekey, :keylessentry, :keylessstart, :engineantitheft)
    end
end
