json.extract! snack, :id, :name, :intro, :history, :practice, :created_at, :updated_at
json.url snack_url(snack, format: :json)