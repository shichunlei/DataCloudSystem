class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action:authenticate_user!

  layout :layout_by_resource

  def layout_by_resource
    if devise_controller?
      "devise_layout"
    else
      "application"
    end
  end
end
