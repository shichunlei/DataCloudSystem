json.extract! world_record, :id, :name, :category, :pic_url, :pic_all_url, :content, :created_at, :updated_at
json.url world_record_url(world_record, format: :json)