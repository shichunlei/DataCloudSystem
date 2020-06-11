class NotificationsController < ApplicationController
  before_action :set_notification, only: [:show, :edit, :update, :destroy]

  # GET /notifications
  def index
    @page = params[:page]
    @notifications = Notification.order(:id).page(@page).per(30)
  end

  # GET /notifications/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /notifications/new
  def new
    @notification = Notification.new
  end

  # GET /notifications/1/edit
  def edit
  end

  # POST /notifications
  def create
    @notification = Notification.new(notification_params)

    if @notification.save
      redirect_to @notification, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /notifications/1
  def update
    if @notification.update(notification_params)
      redirect_to @notification, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /notifications/1
  def destroy
    @notification.destroy
    redirect_to notifications_url, notice: "删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notification
      @notification = Notification.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def notification_params
      params.require(:notification).permit(:notify_type, :user_id, :from_user, :from_user_name, :status, :reason)
    end
end
