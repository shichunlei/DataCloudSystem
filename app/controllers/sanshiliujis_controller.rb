class SanshiliujisController < ApplicationController
  before_action :set_sanshiliuji, only: [:show, :edit, :update, :destroy]
  # GET /sanshiliujis
  def index
    @page = params[:page]
    @sanshiliujis = Sanshiliuji.order(:id).page(@page)
  end
  # GET /sanshiliujis/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /sanshiliujis/new
  def new
    @sanshiliuji = Sanshiliuji.new
  end

  # GET /sanshiliujis/1/edit
  def edit
  end

  # POST /sanshiliujis
  def create
    @sanshiliuji = Sanshiliuji.new(sanshiliuji_params)

    if @sanshiliuji.save
      redirect_to @sanshiliuji, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /sanshiliujis/1
  def update
    if @sanshiliuji.update(sanshiliuji_params)
      redirect_to @sanshiliuji, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /sanshiliujis/1
  def destroy
    @sanshiliuji.destroy
    redirect_to sanshiliujis_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sanshiliuji
      @sanshiliuji = Sanshiliuji.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def sanshiliuji_params
      params.require(:sanshiliuji).permit(:name, :chapter, :gallery, :analogy, :content, :commentary, :comment, :appreciation, :translation, :interpretation, :story, :simple_explanation)
    end
end
