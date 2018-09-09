class SongcisController < ApplicationController
  before_action :set_songci, only: [:show, :edit, :update, :destroy]
  # GET /songcis
  def index
    @page = params[:page]
    @songcis = Songci.order(:id).page(@page).per(30)
  end
  # GET /songcis/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /songcis/new
  def new
    @songci = Songci.new
  end

  # GET /songcis/1/edit
  def edit
  end

  # POST /songcis
  def create
    @songci = Songci.new(songci_params)

    if @songci.save
      redirect_to @songci, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /songcis/1
  def update
    if @songci.update(songci_params)
      redirect_to @songci, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /songcis/1
  def destroy
    @songci.destroy
    redirect_to songcis_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_songci
      @songci = Songci.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def songci_params
      params.require(:songci).permit(:name, :author, :mtype, :content, :explanation, :appreciation)
    end
end
