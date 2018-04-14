class RolesController < ApplicationController
  before_action :set_role, only: [:show, :edit, :update, :destroy]
  # GET /roles
  def index
    @page = params[:page]
    @roles = Role.order(:id).page(@page)
  end
  # GET /roles/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /roles/new
  def new
    @role = Role.new
  end

  # GET /roles/1/edit
  def edit
  end

  # POST /roles
  def create
    @role = Role.new(role_params)

    if @role.save
      redirect_to @role, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /roles/1
  def update
    if @role.update(role_params)
      redirect_to @role, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /roles/1
  def destroy
    @role.destroy
    redirect_to roles_url, notice: "删除成功."
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_role
      @role = Role.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def role_params
      params.require(:role).permit(:name, :resource_id)
    end
end
