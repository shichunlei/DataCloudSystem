module V1
	class Music < Grape::API

		include Utils

		resource :music do

			desc "音乐排行榜榜单分类"
			params do
			end
			get :top_category do
				result = Utils::Helper::get("#{ENV['QQ_MUSIC_URL']}/top/category")

				if result['result'] == 100
					result['data'].each do |item|
						item['list'].each do |sub|
							_result = Utils::Helper::get("#{ENV['QQ_MUSIC_URL']}/top?id=#{sub['value']}&pageSize=5")

							sub.store("subTitle", _result['data']['info']['subTitle'])
							sub.store("titleDetail", _result['data']['info']['titleDetail'])
							sub.store("desc", _result['data']['info']['desc'])

							sub.store("id", _result['data']['id'])
							sub.store("time", _result['data']['time'])
							sub.store("update", _result['data']['update'])
							sub.store("timeType", _result['data']['timeType'])
							sub.store("total", _result['data']['total'])

							list = []
							(0..4).each do |i|
								albumMid = _result['data']['list'][i]['albumMid']
								_result['data']['list'][i].store("albumUrl", "https://y.gtimg.cn/music/photo_new/T002R300x300M000#{albumMid}.jpg?max_age=2592000")
								singer = []
								_singer = {}
								_singer.store('id', -1)
								_singer.store('mid', _result['data']['list'][i]['singerMid'])
								_singer.store('name', _result['data']['list'][i]['singerName'])
								singer.push(_singer)
								_result['data']['list'][i].store('singer', singer)
								list.push(_result['data']['list'][i])
							end

							sub.store("list", list)
							sub.store("coverUrl", list[0]['albumUrl'])
						end
					end

					return {:code => '0', :message => "SUCCESS", :data => result['data'].as_json()}
				else
					return {:code => '1', :message => "失败"}
				end
			end

			desc "榜单详情"
			params do
				requires :id, type: Integer, desc: '榜单ID'
				optional :page, type: Integer, desc: '页码', default: 1
				optional :limit, type: Integer, desc: '每页条数', default: 100
			end
			get :top_info do
				result = Utils::Helper::get("#{ENV['QQ_MUSIC_URL']}/top?id=#{params[:id]}&pageSize=#{params[:limit]}&pageNo=#{params[:page]}")

				if result['result'] == 100
					result['data'].store('label', result['data']['info']['title'])
					result['data'].store('value', "#{result['data']['id']}")
					result['data'].store('subTitle', result['data']['info']['subTitle'])
					result['data'].store('titleDetail', result['data']['info']['titleDetail'])
					result['data'].store('desc', result['data']['info']['desc'])
					result['data'].delete('info')

					result['data']['list'].each do |item|
						item.store("albumUrl", "https://y.gtimg.cn/music/photo_new/T002R300x300M000#{item['albumMid']}.jpg?max_age=2592000")

						singer = []
						_singer = {}
						_singer.store('id', -1)
						_singer.store('mid', item['singerMid'])
						_singer.store('name', item['singerName'])
						singer.push(_singer)
						item.store('singer', singer)
					end
					result['data'].store("coverUrl", result['data']['list'][0]['albumUrl'])

					return {:code => '0', :message => "SUCCESS", :data => result['data'].as_json()}
				else
					return {:code => '1', :message => "失败"}
				end
			end

			desc "歌单分类"
			params do
			end
			get :songlist_category do
				result = Utils::Helper::get("#{ENV['QQ_MUSIC_URL']}/songlist/category")

				if result['result'] == 100
					result['data'].each do |item|
						item.store("title", item['type'])
						item.delete('type')
						item['list'].each do |sub|
							sub.store("label", sub['name'])
							sub.delete('name')
						end
					end

					return {:code => '0', :message => "SUCCESS", :data => result['data'].as_json()}
				else
					return {:code => '1', :message => "失败"}
				end
			end

			desc "根据分类得到歌单列表"
			params do
				requires :id, type: Integer, desc: '分类ID'
				optional :sort, type: Integer, desc: '页码', default: 5 # 默认是 5，// 5: 推荐，2: 最新，其他数字的排列值最后都会返回推荐
				optional :limit, type: Integer, desc: '每页条数', default: 20 # 默认为 20，返回数量
			end
			get :songlist_list do
				result = Utils::Helper::get("#{ENV['QQ_MUSIC_URL']}/songlist/list?category=#{params[:id]}&num=#{params[:limit]}&sort=#{params[:sort]}")

				if result['result'] == 100
					return {:code => '0', :message => "SUCCESS", :data => result['data']['list'].as_json()}
				else
					return {:code => '1', :message => "失败"}
				end
			end

			desc "歌单详情"
			params do
				requires :id, type: Integer, desc: '歌单ID'
			end
			get :songlist_info do
				result = Utils::Helper::get("#{ENV['QQ_MUSIC_URL']}/songlist?id=#{params[:id]}")

				if result['result'] == 100
					songlist = []
					result['data']['songlist'].each do |item|
						object = {}
						object.store("albumUrl", "https://y.gtimg.cn/music/photo_new/T002R300x300M000#{item['albummid']}.jpg?max_age=2592000")
						object.store("singer", item['singer'])
						object.store("title", item['songname'])
						object.store("songId", item['songid'])
						object.store("songMid", item['songmid'])
						object.store("songType", item['songtype'])
						object.store("vid", item['vid'])
						object.store("strMediaMid", item['strMediaMid'])
						object.store("albumMid", item['albummid'])
						object.store("albumDesc", item['albumdesc'])
						object.store("albumName", item['albumname'])
						object.store("albumId", item['albumid'])

						songlist.push(object)
					end
					result['data'].delete('songlist')
					result['data'].store('songlist', songlist)
					result['data'].delete('songids')
					return {:code => '0', :message => "SUCCESS", :data => result['data'].as_json()}
				else
					return {:code => '1', :message => "失败"}
				end
			end

    end
  end
end
