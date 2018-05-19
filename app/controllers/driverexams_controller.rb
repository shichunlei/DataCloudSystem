class DriverexamsController < ApplicationController
  before_action :set_driverexam, only: [:show, :edit, :update, :destroy]

  # GET /driverexams
  def index
    @page = params[:page]
    @driverexams = Driverexam.order(:id).page(@page)
  end

  # GET /driverexams/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /driverexams/new
  def new
    @driverexam = Driverexam.new
  end

  # GET /driverexams/1/edit
  def edit
  end

  # POST /driverexams
  def create
    @driverexam = Driverexam.new(driverexam_params)

    if @driverexam.save
      redirect_to @driverexam, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /driverexams/1
  def update
    if @driverexam.update(driverexam_params)
      redirect_to @driverexam, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /driverexams/1
  def destroy
    @driverexam.destroy
    redirect_to driverexams_url, notice: "删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_driverexam
      @driverexam = Driverexam.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def driverexam_params
      params.require(:driverexam).permit(:subject, :chapter, :q_type, :question, :option1, :option2, :option3, :option4, :pic, :answer, :explain, :chapter_no)
    end
end
