class CarBrand < ApplicationRecord

  def cartype
    CarType.where(car_brand_id:self.id).as_json()
  end
end
