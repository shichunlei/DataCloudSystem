class TangshisController < ApplicationController
  before_action :set_tangshi, only: [:show, :edit, :update, :destroy]
  # GET /tangshis
  def index
    @page = params[:page]
    @tangshis = Tangshi.order(:id).page(@page).per(30)
  end
  # GET /tangshis/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /tangshis/new
  def new
    @tangshi = Tangshi.new
  end

  # GET /tangshis/1/edit
  def edit
  end

  # POST /tangshis
  def create
    @tangshi = Tangshi.new(tangshi_params)

    if @tangshi.save
      redirect_to @tangshi, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /tangshis/1
  def update
    if @tangshi.update(tangshi_params)
      redirect_to @tangshi, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /tangshis/1
  def destroy
    @tangshi.destroy
    redirect_to tangshis_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tangshi
      @tangshi = Tangshi.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def tangshi_params
      params.require(:tangshi).permit(:name, :author, :mtype, :content, :explanation, :appreciation, :tags, :sid, :dynasty, :translation, :background)
    end
end
