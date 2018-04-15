class CarBrandsController < ApplicationController
  before_action :set_car_brand, only: [:show, :edit, :update, :destroy]
  # GET /car_brands
  def index
    @page = params[:page]
    @car_brands = CarBrand.order(:id).page(@page)
  end

  # GET /car_brands/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /car_brands/new
  def new
    @car_brand = CarBrand.new
  end

  # GET /car_brands/1/edit
  def edit
  end

  # POST /car_brands
  def create
    @car_brand = CarBrand.new(car_brand_params)

    if @car_brand.save
      redirect_to @car_brand, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /car_brands/1
  def update
    if @car_brand.update(car_brand_params)
      redirect_to @car_brand, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /car_brands/1
  def destroy
    @car_brand.destroy
    redirect_to car_brands_url, notice: "删除成功."
  end

  def find_brands
    brands = CarBrand.order(:id).limit(20)
    render json:brands.to_json(:only => [:id, :name])
  end

  def search_brands
    brands = CarBrand.where("name LIKE '%#{params[:keyword]}%'").order(:id).limit(20)
    render json:brands.to_json(:only => [:id, :name])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car_brand
      @car_brand = CarBrand.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def car_brand_params
      params.require(:car_brand).permit(:name, :initial, :logo)
    end
end
