class PermissionsController < ApplicationController
  before_action :set_permission, only: [:show, :edit, :update, :destroy]
  # GET /permissions
  def index
    @page = params[:page]
    @permissions = Permission.order(:id).page(@page)
  end
  # GET /permissions/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /permissions/new
  def new
    @permission = Permission.new
  end

  # GET /permissions/1/edit
  def edit
  end

  # POST /permissions
  def create
    @permission = Permission.new(permission_params)

    if @permission.save
      redirect_to @permission, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /permissions/1
  def update
    if @permission.update(permission_params)
      redirect_to @permission, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /permissions/1
  def destroy
    @permission.destroy
    redirect_to permissions_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_permission
      @permission = Permission.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def permission_params
      params.require(:permission).permit(:action, :subject, :description)
    end
end
