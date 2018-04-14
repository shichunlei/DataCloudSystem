class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  # GET /users
  def index
    @page = params[:page]
    @users = User.order(:id).page(@page)
  end
  # GET /users/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user, notice: "创建成功"
    else
      render :new
    end
  end
  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to @user, notice: "修改成功."
    else
      render :edit
    end
  end
  # DELETE /users/1
  def destroy
    @user.destroy
    redirect_to users_url, notice: "删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:password, :mobils, :email, :name, :reset_password_token, :reset_password_sent_at, :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :avatar, :organization_id, :category)
    end
end
