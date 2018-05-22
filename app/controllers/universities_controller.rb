class UniversitiesController < ApplicationController
  before_action :set_university, only: [:show, :edit, :update, :destroy]

  # GET /universities
  def index
    @page = params[:page]
    @universities = University.order("id desc").page(@page).per(20)
  end

  # GET /universities/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /universities/new
  def new
    @university = University.new
  end

  # GET /universities/1/edit
  def edit
  end

  # POST /universities
  def create
    @university = University.new(university_params)

    if @university.save
      redirect_to @university, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /universities/1
  def update
    if @university.update(university_params)
      redirect_to @university, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /universities/1
  def destroy
    @university.destroy
    redirect_to universities_url, notice: "删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_university
      @university = University.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def university_params
      params.require(:university).permit(:universityid, :name, :f211, :f985, :area, :address, :phone, :email, :level, :membership, :nature, :schoolid, :schooltype, :website, :shoufei, :intro)
    end
end
