module V1
	class Cars < Grape::API
		resource :cars do

      desc "获取所有汽车品牌"
      params do
        requires :appkey, type: String, desc: 'AppKey'
      end
      get :car_brands do
        list = CarBrand.all.order(:initial, :id)
        return {"code" => 20001, "message" => "请求成功", :result => list.as_json(:only => [:id, :name, :initial, :logo])}
      end

			desc "根据品牌获得汽车型号"
			params do
				requires :appkey, type: String, desc: 'AppKey'
				requires :brand_id, type: Integer, desc: '品牌ID'
			end
			get :car_types do
				brand_id = params[:brand_id]
				list = CarType.where(car_brand_id:brand_id).order(:parentname, :id)
				return {"code" => 20001, "message" => "请求成功", :result => list.as_json(:only => [:id, :name, :fullname, :salestate, :logo, :parentname])}
			end

			desc "根据汽车型号获得车"
			params do
				requires :appkey, type: String, desc: 'AppKey'
				requires :type_id, type: Integer, desc: '车系ID'
			end
			get :car_models do
				type_id = params[:type_id]
				list = CarModel.where(car_type_id:type_id).order(:id)
				return {"code" => 20001, "message" => "请求成功", :result => list.as_json(:only => [:id, :name, :yeartype, :salestate, :logo, :price, :productionstate, :sizetype])}
			end

			desc "根据汽车ID获得车详情"
			params do
				requires :appkey, type: String, desc: 'AppKey'
				requires :model_id, type: Integer, desc: '车型ID'
			end
			get :car_details do
				model_id = params[:model_id]
				object = CarModel.find_by(id:model_id)
				return {"code" => 20001, "message" => "请求成功", :result => object.as_json(:methods => [:safe, :gearbox, :wheel, :engine, :body, :basic, :light, :seat, :entcom, :actualtest, :aircondrefrigerator, :chassisbrake, :doormirror, :drivingauxiliary, :internalconfig], :only => [:id, :name, :yeartype, :salestate, :logo, :price, :productionstate, :sizetype])}
			end
    end
  end
end
