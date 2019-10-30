class BookDetailsController < ApplicationController
  before_action :set_book_detail, only: [:show, :edit, :update, :destroy]

  # GET /book_details
  def index
    @page = params[:page]
    @book_details = BookDetail.order(:id).page(@page)
  end

  # GET /book_details/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /book_details/new
  def new
    @book_detail = BookDetail.new
  end

  # GET /book_details/1/edit
  def edit
  end

  # POST /book_details
  def create
    @book_detail = BookDetail.new(book_detail_params)

    if @book_detail.save
      redirect_to @book_detail, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /book_details/1
  def update
    if @book_detail.update(book_detail_params)
      redirect_to @book_detail, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /book_details/1
  def destroy
    @book_detail.destroy
    redirect_to book_details_url, notice: "删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book_detail
      @book_detail = BookDetail.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def book_detail_params
      params.require(:book_detail).permit(:book_id, :chapter, :name, :author, :sid, :category, :dynasty, :content, :commentary, :translation, :appreciation, :interpretation, :background, :tags)
    end
end
