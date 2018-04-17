json.extract! todayhistory, :id, :name, :year, :month, :day, :image, :content, :created_at, :updated_at
json.url todayhistory_url(todayhistory, format: :json)