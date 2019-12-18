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
								item = _result['data']['list'][i]
								object = {}
								object.store("rank", item['rank'])
								object.store("rankType", item['rankType'])
								object.store("rankValue", item['rankValue'])
								object.store("recType", item['recType'])
								object.store("title", item['title'])
								object.store("songId", item['id'])
								object.store("songMid", item['mid'])
								object.store("songType", item['songType'])
								object.store("vid", item['vid'])
								object.store("albumMid", item['albumMid'])
								object.store("albumDesc", item["subtitle"])
								object.store("albumName", item['name'])
								# object.store("album", _result['data']['list'][i]['album']['id'])
								object.store("albumUrl", "https://y.gtimg.cn/music/photo_new/T002R300x300M000#{item['albumMid']}.jpg?max_age=2592000")
								object.store("singer", item['singer'])
								list.push(object)
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

					list = []
					result['data']['list'].each do |item|
						object = {}
						object.store("rank", item['rank'])
						object.store("rankType", item['rankType'])
						object.store("rankValue", item['rankValue'])
						object.store("recType", item['recType'])
						object.store("title", item['title'])
						object.store("songId", item['id'])
						object.store("songMid", item['mid'])
						object.store("songType", item['songType'])
						object.store("vid", item['vid'])
						object.store("albumMid", item['albumMid'])
						object.store("albumDesc", item["subtitle"])
						object.store("albumName", item['name'])
						object.store("albumId", item['album']['id'])
						object.store("albumUrl", "https://y.gtimg.cn/music/photo_new/T002R300x300M000#{item['albumMid']}.jpg?max_age=2592000")
						object.store("singer", item['singer'])
						list.push(object)
					end
					result['data'].store('list', list)
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
				requires :id, type: String, desc: '歌单ID'
			end
			get :songlist_info do
				result = Utils::Helper::get("#{ENV['QQ_MUSIC_URL']}/songlist?id=#{params[:id]}")

				if result['result'] == 100
					songlist = []
					result['data']['songlist'].each do |item|
						object = {}
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
						object.store("albumUrl", "https://y.gtimg.cn/music/photo_new/T002R300x300M000#{item['albummid']}.jpg?max_age=2592000")
						object.store("singer", item['singer'])

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

			desc "为你推荐歌单"
			params do
			end
			get :recommend_playlist_u do
				result = Utils::Helper::get("#{ENV['QQ_MUSIC_URL']}/recommend/playlist/u")

				data = []
				if result['result'] == 100
					result['data']['list'].each do |item|
						object = {}
						object.store('dissid', item['content_id'])
						object.store('dissname', item['title'])
						object.store('createtime', "")
						object.store('commit_time', '')
						object.store('listennum', item['listen_num'])
						object.store('imgurl', item['cover'])
						creator = {}
						creator.store("qq", item['creator'])
						creator.store("name", item['username'])
						object.store('creator', creator)
						data.push(object)
					end

					return {:code => '0', :message => "SUCCESS", :data => data.as_json()}
				else
					return {:code => '1', :message => "失败"}
				end
			end

			desc "按分类推荐歌单"
			params do
				requires :id, type: Integer, desc: '分类ID' # 分类id，默认为 3317 // 3317: 官方歌单，59：经典，71：情歌，3056：网络歌曲，64：KTV热歌
				optional :page, type: Integer, desc: '页码', default: 1
				optional :limit, type: Integer, desc: '每页条数', default: 20
			end
			get :recommend_playlist do
				result = Utils::Helper::get("#{ENV['QQ_MUSIC_URL']}/recommend/playlist?id=#{params[:id]}&pageNo=#{params[:page]}&pageSize=#{params[:limit]}")

				data = []
				if result['result'] == 100
					result['data']['list'].each do |item|
						object = {}
						object.store('dissid', item['tid'])
						object.store('dissname', item['title'])
						object.store('createtime', item['create_time'])
						object.store('commit_time', item['commit_time'])
						object.store('score', item['score'])
						object.store('imgurl', item['cover_url_big'])
						creator = {}
						creator.store("qq", item['creator_uin'])
						creator.store("name", item['creator_info']['nick'])
						object.store('creator', creator)
						data.push(object)
					end

					return {:code => '0', :message => "SUCCESS", :data => data.as_json()}
				else
					return {:code => '1', :message => "失败"}
				end
			end

			desc "歌曲详情"
			params do
				requires :id, type: String, desc: '分类ID'
			end
			get :song_info do
				result = Utils::Helper::get("#{ENV['QQ_MUSIC_URL']}/song?songmid=#{params[:id]}")

				if result['result'] == 100
					result['data']['track_info'].store('company', result['data']['info']['company']['content'][0]['value'])
					result['data']['track_info'].store('company_id', result['data']['info']['company']['content'][0]['id'])

					result['data']['track_info'].store('genre', result['data']['info']['genre']['content'][0]['value'])
					result['data']['track_info'].store('genre_id', result['data']['info']['genre']['content'][0]['id'])

					result['data']['track_info'].store('language', result['data']['info']['lan']['content'][0]['value'])
					result['data']['track_info'].store('pub_time', result['data']['info']['pub_time']['content'][0]['value'])

					url_result = Utils::Helper::get("#{ENV['QQ_MUSIC_URL']}/song/urls?id=#{params[:id]}")
					if url_result['result'] == 100
						url = url_result['data']["#{params[:id]}"]

						result['data']['track_info'].store('url', url.gsub('http://124.89.197.18/amobile.music.tc.qq.com', "http://ws.stream.qqmusic.qq.com"))
					end

					lyric_result = Utils::Helper::get("#{ENV['QQ_MUSIC_URL']}/lyric?songmid=#{params[:id]}")
					if lyric_result['result'] == 100
						result['data']['track_info'].store('lyric', lyric_result['data']['lyric'])
						result['data']['track_info'].store('lyric_trans', lyric_result['data']['trans'])
					end

					result['data']['track_info'].delete('pay')
					result['data']['track_info'].delete('action')

					return {:code => '0', :message => "SUCCESS", :data => result['data']['track_info'].as_json()}
				else
					return {:code => '1', :message => "失败"}
				end
			end

    end
  end
end
