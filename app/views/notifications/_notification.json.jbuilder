json.extract! notification, :id, :notify_type, :user_id, :from_user_id, :from_user_name, :status, :reason, :created_at, :updated_at
json.url notification_url(notification, format: :json)
