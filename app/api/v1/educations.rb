module V1
	class Educations < Grape::API
		resource :educations do

			desc "唐诗类别"
			params do
			end
			get :tangshi_types do
				list = Tangshi.order(:id).as_json(:only => [:mtype])
				arr = []
				list.each do |item|
					arr.push(item["mtype"])
				end
				return {"code" => 20001, "message" => "请求成功", :result => arr.uniq}
			end

      desc "唐诗列表"
			params do
				requires :mtype, type: String, desc: '唐诗类别'
			end
			get :tangshi_list do
				list = Tangshi.where(mtype:params[:mtype]).order(:id)
				return {"code" => 20001, "message" => "请求成功", :result => list.as_json(:only => [:id, :name, :author])}
			end

			desc "唐诗详情"
			params do
				requires :id, type: Integer, desc: 'ID'
			end
			get :tangshi_details do
				object = Tangshi.find_by(id:params[:id])
				return {"code" => 20001, "message" => "请求成功", :result => object.as_json(:only => [:id, :name, :author, :mtype, :content, :explanation, :appreciation])}
			end

			desc "宋词类别"
			params do
			end
			get :songci_types do
				list = Songci.order(:id).as_json(:only => [:mtype])
				arr = []
				list.each do |item|
					arr.push(item["mtype"])
				end
				return {"code" => 20001, "message" => "请求成功", :result => arr.uniq}
			end

      desc "宋词列表"
			params do
				requires :mtype, type: String, desc: '唐诗类别'
			end
			get :songci_list do
				list = Songci.where(mtype:params[:mtype]).order(:id)
				return {"code" => 20001, "message" => "请求成功", :result => list.as_json(:only => [:id, :name, :author])}
			end

			desc "宋词详情"
			params do
				requires :id, type: Integer, desc: 'ID'
			end
			get :songci_details do
				object = Songci.find_by(id:params[:id])
				return {"code" => 20001, "message" => "请求成功", :result => object.as_json(:only => [:id, :name, :author, :mtype, :content, :explanation, :appreciation])}
			end

			desc "元曲列表"
			params do
			end
			get :yuanqu_list do
				list = Yuanqu.order(:id)
				return {"code" => 20001, "message" => "请求成功", :result => list.as_json(:only => [:id, :name, :author])}
			end

			desc "元曲详情"
			params do
				requires :id, type: Integer, desc: 'ID'
			end
			get :yuanqu_details do
				object = Yuanqu.find_by(id:params[:id])
				return {"code" => 20001, "message" => "请求成功", :result => object.as_json(:only => [:id, :name, :author, :content, :explanation, :appreciation])}
			end

    end
  end
end
