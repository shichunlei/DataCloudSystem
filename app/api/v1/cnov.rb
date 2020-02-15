module V1
	class Cnov < Grape::API

    include Utils

		resource :cnov do

      desc "抗击疫情-nCoV疫情实时播报"
      params do
      end
      get :ncovindex do
				header = {
					"Content-Type" => "application/x-www-form-urlencoded"
				}

				params = {
					:key => '7cfb4a16bb628d90a4043a707cbfca2f'
				}

        result = Utils::Helper::post("http://api.tianapi.com/txapi/ncov/index", params, header)

        if result['code'] == 200
          return {:code => 0, :message => "SUCCESS", :data => result['newslist'][0].as_json()}
        else
          return {:code => result['code'], :message => result['msg']}
        end
      end

			desc "肺炎疫情-抗击肺炎疫情城市数据"
      params do
      end
      get :ncovcity do
				header = {
					"Content-Type" => "application/x-www-form-urlencoded"
				}

				params = {
					:key => '7cfb4a16bb628d90a4043a707cbfca2f'
				}

        result = Utils::Helper::post("http://api.tianapi.com/txapi/ncovcity/index", params, header)

        if result['code'] == 200
          return {:code => 0, :message => "SUCCESS", :data => result['newslist'].as_json()}
        else
          return {:code => result['code'], :message => result['msg']}
        end
      end

			desc "肺炎疫情-抗击肺炎疫情全球数据"
      params do
      end
      get :ncovcountry do
				result = Utils::Helper::get("http://49.232.173.220:3001/data/getListByCountryTypeService2")

				continents = []

				result.each do |item|
					continent = {}
					continent.store("continentName", item['continents'])
					continents.push(continent)
				end

				array = continents.uniq

				array.each do |arr|
					country = []
					totalDeadCount = 0
					totalCurrentConfirmedCount = 0
					totalConfirmedCount = 0
					totalSuspectedCount = 0
					totalCuredCount = 0
					result.each do |item|
						if item["continents"] == arr['continentName']
							totalDeadCount += item['deadCount']
							totalCurrentConfirmedCount += item['currentConfirmedCount']
							totalConfirmedCount += item['confirmedCount']
							totalSuspectedCount += item['suspectedCount']
							totalCuredCount += item['curedCount']
							item.delete('continents')
							item.delete('cityName')
							item.store("countryName", item['provinceName'])
							item.delete('provinceName')
							item.store("countryId", item['provinceId'])
							item.delete('provinceId')
							item.delete('provinceShortName')
							country.push(item)
						end
					end
					arr.store("currentConfirmedCount", totalCurrentConfirmedCount)
					arr.store("deadCount", totalDeadCount)
					arr.store("confirmedCount", totalConfirmedCount)
					arr.store("suspectedCount", totalSuspectedCount)
					arr.store("curedCount", totalCuredCount)
					arr.store("country", country)
				end

        return {:code => 0, :message => "SUCCESS", :data => array.as_json()}
      end

			desc "谣言鉴别-网络谣言鉴别接口"
      params do
        requires :page, type: Integer, desc: '页码'
				optional :num, type: Integer, desc: '每页条数', default: 10
        optional :word, type: String, desc: '关键词'
      end
      get :rumour do
				header = {
					"Content-Type" => "application/x-www-form-urlencoded"
				}

				_params = declared(params)
				_params.store('key', '7cfb4a16bb628d90a4043a707cbfca2f')
				_params.delete_if{|k, v| v == nil || v == ""}

        result = Utils::Helper::post("http://api.tianapi.com/txapi/rumour/index", _params, header)

        if result['code'] == 200
          return {:code => 0, :message => "SUCCESS", :data => result['newslist'].as_json()}
        else
          return {:code => result['code'], :message => result['msg']}
        end
      end

			desc "肺炎同程查询-肺炎疫情确诊同程"
      params do
				requires :page, type: Integer, desc: '页码'
				optional :num, type: Integer, desc: '每页条数', default: 10
        optional :type, type: Integer, desc: '交通类型', default: 1 # 默认飞机，1飞机，2火车，3地铁，4长途客车/大巴，5公交车，6出租车，7轮船，8其他公共场所
				optional :date, type: String, desc: '时间'
        optional :no, type: String, desc: '车次'
				optional :arrive, type: String, desc: '到达地点'
      end
      get :ncovsame do
				header = {
					"Content-Type" => "application/x-www-form-urlencoded"
				}

				_params = declared(params)
				_params.store('key', '7cfb4a16bb628d90a4043a707cbfca2f')
				_params.delete_if{|k, v| v == nil || v == ""}

        result = Utils::Helper::post("http://api.tianapi.com/txapi/ncovsame/index", _params, header)

        if result['code'] == 200
          return {:code => 0, :message => "SUCCESS", :data => result['newslist'].as_json()}
        else
          return {:code => result['code'], :message => result['msg']}
        end
      end

			desc "获取全国最新的新闻数据"
      params do
      end
      get :news do
        result = Utils::Helper::get("http://49.232.173.220:3001/data/getTimelineService")

        return {:code => 0, :message => "SUCCESS", :data => result.as_json()}
      end

			desc "获取全国最新的新闻数据详情"
      params do
				requires :id, type: String, desc: '新闻ID'
      end
      get :newsinfo do
				id = params[:id]

        result = Utils::Helper::get("http://49.232.173.220:3001/data/getNewest/#{id}")

        return {:code => 0, :message => "SUCCESS", :data => result.as_json()}
      end

			desc "获取整体统计信息"
      params do
      end
      get :statistics do
        result = Utils::Helper::get("http://49.232.173.220:3001/data/getStatisticsService")

				resultCity = Utils::Helper::get("http://data.chingsoft.com/api/v1/cnov/ncovcity")

				result.store("provinces", resultCity['data'])

				resultContinent = Utils::Helper::get("http://49.232.173.220:3001/data/getListByCountryTypeService2")

				continents = []

				resultContinent.each do |item|
					continent = {}
					continent.store("continentName", item['continents'])
					continents.push(continent)
				end

				array = continents.uniq

				array.each do |arr|
					country = []
					totalDeadCount = 0
					totalCurrentConfirmedCount = 0
					totalConfirmedCount = 0
					totalSuspectedCount = 0
					totalCuredCount = 0
					resultContinent.each do |item|
						if item["continents"] == arr['continentName']
							totalDeadCount += item['deadCount']
							totalCurrentConfirmedCount += item['currentConfirmedCount']
							totalConfirmedCount += item['confirmedCount']
							totalSuspectedCount += item['suspectedCount']
							totalCuredCount += item['curedCount']
							item.delete('continents')
							item.delete('cityName')
							item.store("countryName", item['provinceName'])
							item.delete('provinceName')
							item.store("countryId", item['provinceId'])
							item.delete('provinceId')
							item.delete('provinceShortName')
							country.push(item)
						end
					end
					arr.store("currentConfirmedCount", totalCurrentConfirmedCount)
					arr.store("deadCount", totalDeadCount)
					arr.store("confirmedCount", totalConfirmedCount)
					arr.store("suspectedCount", totalSuspectedCount)
					arr.store("curedCount", totalCuredCount)
					arr.store("country", country)
				end

				result.store("continents", array)

        return {:code => 0, :message => "SUCCESS", :data => result.as_json()}
      end

			desc "最新知识百科"
      params do
      end
      get :wikilist do
        result = Utils::Helper::get("http://49.232.173.220:3001/data/getWikiList?pageNum=1&pageSize=5")

        return {:code => 0, :message => "SUCCESS", :data => result['result'].as_json()}
      end

    end
  end
end
