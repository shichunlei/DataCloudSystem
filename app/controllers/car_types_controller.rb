class CarTypesController < ApplicationController
  before_action :set_car_type, only: [:show, :edit, :update, :destroy]
  # GET /car_types
  def index
    @page = params[:page]
    @car_types = CarType.order(:id).page(@page)
  end

  # GET /car_types/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /car_types/new
  def new
    @car_type = CarType.new
  end

  # GET /car_types/1/edit
  def edit
  end

  # POST /car_types
  def create
    @car_type = CarType.new(car_type_params)

    if @car_type.save
      redirect_to @car_type, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /car_types/1
  def update
    if @car_type.update(car_type_params)
      redirect_to @car_type, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /car_types/1
  def destroy
    @car_type.destroy
    redirect_to car_types_url, notice: "删除成功."
  end

  def find_types
    brands = CarType.order(:id).limit(20)
    render json:brands.to_json(:only => [:id, :name])
  end

  def search_types
    brands = CarType.where("name LIKE '%#{params[:keyword]}%'").order(:id).limit(20)
    render json:brands.to_json(:only => [:id, :name])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car_type
      @car_type = CarType.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def car_type_params
      params.require(:car_type).permit(:name, :fullname, :parentname, :logo, :salestate, :car_brand_id)
    end
end
