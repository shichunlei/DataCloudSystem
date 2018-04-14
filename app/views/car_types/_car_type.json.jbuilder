json.extract! car_type, :id, :name, :fullname, :parentname, :logo, :salestate, :car_brand_id, :created_at, :updated_at
json.url car_type_url(car_type, format: :json)