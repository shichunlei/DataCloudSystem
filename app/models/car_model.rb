class CarModel < ApplicationRecord
  belongs_to :car_type

  def actualtest
    CarActualtest.find_by(car_model_id:self.id).as_json()
  end

  def aircondrefrigerator
    CarAircondrefrigerator.find_by(car_model_id:self.id).as_json()
  end

  def basic
    CarBasic.find_by(car_model_id:self.id).as_json()
  end

  def body
    CarBody.find_by(car_model_id:self.id).as_json()
  end

  def chassisbrake
    CarChassisbrake.find_by(car_model_id:self.id).as_json()
  end

  def doormirror
    CarDoormirror.find_by(car_model_id:self.id).as_json()
  end

  def drivingauxiliary
    CarDrivingauxiliary.find_by(car_model_id:self.id).as_json()
  end

  def engine
    CarEngine.find_by(car_model_id:self.id).as_json()
  end

  def entcom
    CarEntcom.find_by(car_model_id:self.id).as_json()
  end

  def gearbox
    CarGearbox.find_by(car_model_id:self.id).as_json()
  end

  def internalconfig
    CarInternalconfig.find_by(car_model_id:self.id).as_json()
  end

  def light
    CarLight.find_by(car_model_id:self.id).as_json()
  end

  def safe
    CarSafe.find_by(car_model_id:self.id).as_json()
  end

  def seat
    CarSeat.find_by(car_model_id:self.id).as_json()
  end

  def wheel
    CarWheel.find_by(car_model_id:self.id).as_json()
  end

end
