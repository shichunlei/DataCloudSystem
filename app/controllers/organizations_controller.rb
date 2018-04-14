class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show, :edit, :update, :destroy]
  # GET /organizations
  def index
    @page = params[:page]
    @organizations = Organization.order(:id).page(@page)
  end
  # GET /organizations/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /organizations/new
  def new
    @organization = Organization.new
  end

  # GET /organizations/1/edit
  def edit
  end

  # POST /organizations
  def create
    @organization = Organization.new(organization_params)

    if @organization.save
      redirect_to @organization, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /organizations/1
  def update
    if @organization.update(organization_params)
      redirect_to @organization, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /organizations/1
  def destroy
    @organization.destroy
    redirect_to organizations_url, notice: "删除成功."
  end

  #GET /find_organization
  def find_organization
    organization = Organization.limit(10)
    render json:organization.to_json(:only => [:id,:name])
  end
  # PUT /search/organization_all
  def organization_all
    organization = Organization.where("name LIKE '%#{params[:keyword]}%'").limit(10)
    render json:organization.to_json(:only => [:id,:name])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Organization.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def organization_params
      params.require(:organization).permit(:name, :description, :organization_id)
    end
end
