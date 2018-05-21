class WorldRecordsController < ApplicationController
  before_action :set_world_record, only: [:show, :edit, :update, :destroy]

  # GET /world_records
  def index
    @page = params[:page]
    @world_records = WorldRecord.order(:id).page(@page)
  end

  # GET /world_records/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /world_records/new
  def new
    @world_record = WorldRecord.new
  end

  # GET /world_records/1/edit
  def edit
  end

  # POST /world_records
  def create
    @world_record = WorldRecord.new(world_record_params)

    if @world_record.save
      redirect_to @world_record, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /world_records/1
  def update
    if @world_record.update(world_record_params)
      redirect_to @world_record, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /world_records/1
  def destroy
    @world_record.destroy
    redirect_to world_records_url, notice: "删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_world_record
      @world_record = WorldRecord.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def world_record_params
      params.require(:world_record).permit(:name, :category, :pic_url, :pic_all_url, :content)
    end
end
