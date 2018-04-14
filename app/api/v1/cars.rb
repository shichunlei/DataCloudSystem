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

    end
  end
end
