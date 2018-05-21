json.extract! airport, :id, :name, :iata, :icao, :other_name, :country_id, :city_name, :intro, :created_at, :updated_at
json.url airport_url(airport, format: :json)