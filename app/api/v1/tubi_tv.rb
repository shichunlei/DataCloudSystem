module V1
	class TubiTV < Grape::API

		resource :tubitv do

			desc "首页"
      params do
        requires :device_id, type: String, desc: '设备ID'
        requires :platform, type: String, desc: '平台类型'
      end
      get :homescreen do
        device_id = params[:device_id]
        platform = params[:platform]
        user_id = params[:user_id]

        result = Utils::Helper::get("https://uapi.adrise.tv/matrix/homescreen?app_id=tubitv&platform=#{platform}&device_id=#{device_id}")

        result['containers'].each do |item|
          array = []
          item['children'].each do |id|
            array.push(result['contents']["#{id}"])
          end
          item.delete('children')
          item.store("children", array)
        end

        return {:code => 0, :message => "SUCCESS", :data => result['containers'].as_json()}
      end

      desc "分类列表"
      params do
        requires :page, type: Integer, desc: '页码'
        requires :category, type: String, desc: '类型'
        optional :limit, type: Integer, desc: '每页条数'
      end
      get :list do
        page = params[:page]
        category = params[:category]
        limit = params[:limit]

        start = (page - 1) * limit

        result = Utils::Helper::get("https://tubitv.com/oz/containers/#{category}/content?app_id=tubitv&parentId&cursor=#{start}&limit=#{limit}")

        data = []

        result['contents'].each do |key, value|
          data.push(value)
        end

        return {:code => 0, :message => "SUCCESS", :data => data.as_json()}
      end

      desc "详情"
      params do
        requires :id, type: String, desc: 'ID'
        requires :device_id, type: String, desc: '设备ID'
        requires :platform, type: String, desc: '平台类型'
      end
      get :details do
        id = params[:id]
        if id.length <= 4
          id = "0#{id}"
        end
        device_id = params[:device_id]
        platform = params[:platform]

        result = Utils::Helper::get("https://uapi.adrise.tv/cms/content?app_id=tubitv&content_id=#{id}&includeChannels=true&device_id=#{device_id}&platform=#{platform}")

        # 推荐结果
        related_result = Utils::Helper::get("https://uapi.adrise.tv/cms/content/#{id}/related?device_id=#{device_id}&platform=#{platform}")

        result.store("related", related_result)

        return {:code => 0, :message => "SUCCESS", :data => result.as_json()}
      end

      desc "搜索"
      params do
        requires :key, type: String, desc: '搜索关键字'
        requires :device_id, type: String, desc: '设备ID'
        requires :platform, type: String, desc: '平台类型'
      end
      get :search do
        key = params[:key]
        device_id = params[:device_id]
        platform = params[:platform]
        result = Utils::Helper::get("https://uapi.adrise.tv/cms/search?app_id=tubitv&categorize=false&device_id=#{device_id}&platform=#{platform}&search=#{key}")

        return {:code => 0, :message => "SUCCESS", :data => result.as_json()}
      end

    end
  end
end
