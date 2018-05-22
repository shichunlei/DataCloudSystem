class HospitalsController < ApplicationController
  before_action :set_hospital, only: [:show, :edit, :update, :destroy]

  # GET /hospitals
  def index
    @page = params[:page]
    @hospitals = Hospital.order("id desc").page(@page).per(20)
  end

  # GET /hospitals/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /hospitals/new
  def new
    @hospital = Hospital.new
  end

  # GET /hospitals/1/edit
  def edit
  end

  # POST /hospitals
  def create
    @hospital = Hospital.new(hospital_params)

    if @hospital.save
      redirect_to @hospital, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /hospitals/1
  def update
    if @hospital.update(hospital_params)
      redirect_to @hospital, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /hospitals/1
  def destroy
    @hospital.destroy
    redirect_to hospitals_url, notice: "删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hospital
      @hospital = Hospital.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def hospital_params
      params.require(:hospital).permit(:name, :nature, :grade, :province, :city, :area, :address, :phone, :dean, :about, :specialist, :year, :department, :equipment, :bed_number, :medical_workers, :honor, :annual_outpatient_service, :department_number, :health_insurance)
    end
end
