json.extract! car_basic, :id, :price, :saleprice, :warrantypolicy, :vechiletax, :displacement, :gearbox, :comfuelconsumption, :userfuelconsumption, :officialaccelerationtime100, :maxspeed, :seatnum, :car_model_id, :created_at, :updated_at
json.url car_basic_url(car_basic, format: :json)