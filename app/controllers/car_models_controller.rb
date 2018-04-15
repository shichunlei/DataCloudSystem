class CarModelsController < ApplicationController
  before_action :set_car_model, only: [:show, :edit, :update, :destroy]

  # GET /car_models
  def index
    @page = params[:page]
    @car_models = CarModel.order(:id).page(@page)
  end

  # GET /car_models/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /car_models/new
  def new
    @car_model = CarModel.new
  end

  # GET /car_models/1/edit
  def edit
  end

  # POST /car_models
  def create
    @car_model = CarModel.new(car_model_params)

    if @car_model.save
      redirect_to @car_model, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /car_models/1
  def update
    if @car_model.update(car_model_params)
      redirect_to @car_model, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /car_models/1
  def destroy
    @car_model.destroy
    redirect_to car_models_url, notice: "删除成功."
  end

  def find_models
    brands = CarModel.limit(20)
    render json:brands.to_json(:only => [:id, :name])
  end

  def search_models
    brands = CarModel.where("name LIKE '%#{params[:keyword]}%'").limit(20)
    render json:brands.to_json(:only => [:id, :name])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car_model
      @car_model = CarModel.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def car_model_params
      params.require(:car_model).permit(:name, :price, :logo, :salestate, :yeartype, :productionstate, :sizetype, :car_type_id)
    end
end
