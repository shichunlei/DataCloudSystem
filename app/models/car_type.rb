class CarType < ApplicationRecord
  belongs_to :car_brand

  def carmodel
    CarModel.where(car_type_id:self.id)
  end
end
