class MiyuClassifiesController < ApplicationController
  before_action :set_miyu_classify, only: [:show, :edit, :update, :destroy]

  # GET /miyu_classifies
  def index
    @page = params[:page]
    @miyu_classifies = MiyuClassify.order(:id).page(@page)
  end

  # GET /miyu_classifies/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /miyu_classifies/new
  def new
    @miyu_classify = MiyuClassify.new
  end

  # GET /miyu_classifies/1/edit
  def edit
  end

  # POST /miyu_classifies
  def create
    @miyu_classify = MiyuClassify.new(miyu_classify_params)

    if @miyu_classify.save
      redirect_to @miyu_classify, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /miyu_classifies/1
  def update
    if @miyu_classify.update(miyu_classify_params)
      redirect_to @miyu_classify, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /miyu_classifies/1
  def destroy
    @miyu_classify.destroy
    redirect_to miyu_classifies_url, notice: "删除成功."
  end

  def find_classify
    classify = MiyuClassify.order(:id)
    render json:classify.to_json(:only => [:id, :name])
  end

  def search_classify
    classify = MiyuClassify.where("name LIKE '%#{params[:keyword]}%'").order(:id)
    render json:classify.to_json(:only => [:id, :name])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_miyu_classify
      @miyu_classify = MiyuClassify.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def miyu_classify_params
      params.require(:miyu_classify).permit(:name)
    end
end
