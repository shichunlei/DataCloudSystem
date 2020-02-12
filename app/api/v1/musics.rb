module V1
	class Musics < Grape::API

		include Utils

		resource :musics do

			desc ""
			params do
			end
			get :list do
				result = Music.all

				return {:code => "0", :message => "SUCCESS", :data => result.as_json(:only => [:id, :name, :audio_url, :artists, :album_url, :lyric])}
			end

			desc "音乐排行榜榜单分类"
			params do
			end
			get :top_category do
				result = Utils::Helper::get("#{ENV["QQ_MUSIC_URL"]}/top/category?showDetail=1")

				if result["result"] == 100
					result["data"].each do |item|
						item["list"].each do |sub|
							sub.store("id", sub["topId"])
							sub.store("desc", sub["intro"])
							sub.store("update", sub["updateTime"])
							sub.delete("topId")
							sub.delete("updateTime")
							sub.delete("intro")

							sub[song].each do |song|
								song.store("albumUrl", "https://y.gtimg.cn/music/photo_new/T002R300x300M000#{item["albumMid"]}.jpg?max_age=2592000")
								singer = []
								_singer = {}
								_singer.store("mid", song["singerMid"])
								_singer.store("name", song["singerName"])
								singer.push(_singer)
								song.store("singer", singer)
								song.delete("singerMid")
								song.delete("singerName")
							end
							sub.store("list", sub[song])
							sub.delete("song")
						end
					end

					return {:code => "0", :message => "SUCCESS", :data => result["data"].as_json()}
				else
					return {:code => "1", :message => result["errMsg"]}
				end
			end

			desc "榜单详情"
			params do
				requires :id, type: Integer, desc: "榜单ID"
				requires :period, type: String, desc: "榜单的时间"
				optional :page, type: Integer, desc: "页码", default: 1
				optional :limit, type: Integer, desc: "每页条数", default: 100
			end
			get :top_info do
				result = Utils::Helper::get("#{ENV["QQ_MUSIC_URL"]}/top?id=#{params[:id]}&pageSize=#{params[:limit]}&pageNo=#{params[:page]}&period=#{params[:period]}")

				if result["result"] == 100
					result["data"].store("label", result["data"]["info"]["title"])
					result["data"].store("subTitle", result["data"]["info"]["subTitle"])
					result["data"].store("titleDetail", result["data"]["info"]["titleDetail"])
					result["data"].store("desc", result["data"]["info"]["desc"])
					result["data"].delete("info")

					list = []
					result["data"]["list"].each do |item|
						object = {}
						object.store("rank", item["rank"])
						object.store("rankType", item["rankType"])
						object.store("rankValue", item["rankValue"])
						object.store("recType", item["recType"])
						object.store("title", item["title"])
						object.store("songId", item["id"])
						object.store("songMid", item["mid"])
						object.store("songType", item["songType"])
						object.store("vid", item["vid"])
						object.store("albumMid", item["albumMid"])
						object.store("albumDesc", item["album"]["subtitle"])
						object.store("albumName", item["album"]["name"])
						object.store("albumId", item["album"]["id"])
						object.store("albumUrl", "https://y.gtimg.cn/music/photo_new/T002R300x300M000#{item["albumMid"]}.jpg?max_age=2592000")
						object.store("singer", item["singer"])
						list.push(object)
					end
					result["data"].store("list", list)

					return {:code => "0", :message => "SUCCESS", :data => result["data"].as_json()}
				else
					return {:code => "1", :message => result["errMsg"]}
				end
			end

			desc "歌单分类"
			params do
			end
			get :songlist_category do
				result = Utils::Helper::get("#{ENV["QQ_MUSIC_URL"]}/songlist/category")

				if result["result"] == 100
					result["data"].each do |item|
						item.store("title", item["type"])
						item.delete("type")
						item["list"].each do |sub|
							sub.store("label", sub["name"])
							sub.delete("name")
						end
					end

					return {:code => "0", :message => "SUCCESS", :data => result["data"].as_json()}
				else
					return {:code => "1", :message => result["errMsg"]}
				end
			end

			desc "根据分类得到歌单列表"
			params do
				requires :id, type: Integer, desc: "分类ID"
				optional :sort, type: Integer, desc: "页码", default: 5 # 默认是 5，// 5: 推荐，2: 最新，其他数字的排列值最后都会返回推荐
				optional :limit, type: Integer, desc: "每页条数", default: 20 # 默认为 20，返回数量
			end
			get :songlist_list do
				result = Utils::Helper::get("#{ENV["QQ_MUSIC_URL"]}/songlist/list?category=#{params[:id]}&num=#{params[:limit]}&sort=#{params[:sort]}")

				if result["result"] == 100
					return {:code => "0", :message => "SUCCESS", :data => result["data"]["list"].as_json()}
				else
					return {:code => "1", :message => result["errMsg"]}
				end
			end

			desc "歌单详情"
			params do
				requires :id, type: String, desc: "歌单ID"
			end
			get :songlist_info do
				result = Utils::Helper::get("#{ENV["QQ_MUSIC_URL"]}/songlist?id=#{params[:id]}")

				if result["result"] == 100
					songlist = []
					result["data"]["songlist"].each do |item|
						object = {}
						object.store("title", item["songname"])
						object.store("songId", item["songid"])
						object.store("songMid", item["songmid"])
						object.store("songType", item["songtype"])
						object.store("vid", item["vid"])
						object.store("strMediaMid", item["strMediaMid"])
						object.store("albumMid", item["albummid"])
						object.store("albumDesc", item["albumdesc"])
						object.store("albumName", item["albumname"])
						object.store("albumId", "#{item["albumid"]}")
						object.store("albumUrl", "https://y.gtimg.cn/music/photo_new/T002R300x300M000#{item["albummid"]}.jpg?max_age=2592000")
						object.store("singer", item["singer"])

						songlist.push(object)
					end
					result["data"].delete("songlist")
					result["data"].store("songlist", songlist)
					result["data"].delete("songids")
					return {:code => "0", :message => "SUCCESS", :data => result["data"].as_json()}
				else
					return {:code => "1", :message => result["errMsg"]}
				end
			end

			desc "为你推荐歌单"
			params do
			end
			get :recommend_playlist_u do
				result = Utils::Helper::get("#{ENV["QQ_MUSIC_URL"]}/recommend/playlist/u")

				data = []
				if result["result"] == 100
					result["data"]["list"].each do |item|
						object = {}
						object.store("dissid", item["content_id"])
						object.store("dissname", item["title"])
						object.store("createtime", "")
						object.store("commit_time", "")
						object.store("listennum", item["listen_num"])
						object.store("imgurl", item["cover"])
						creator = {}
						creator.store("qq", item["creator"])
						creator.store("name", item["username"])
						object.store("creator", creator)
						data.push(object)
					end

					return {:code => "0", :message => "SUCCESS", :data => data.as_json()}
				else
					return {:code => "1", :message => result["errMsg"]}
				end
			end

			desc "按分类推荐歌单"
			params do
				requires :id, type: Integer, desc: "分类ID" # 分类id，默认为 3317 // 3317: 官方歌单，59：经典，71：情歌，3056：网络歌曲，64：KTV热歌
				optional :page, type: Integer, desc: "页码", default: 1
				optional :limit, type: Integer, desc: "每页条数", default: 20
			end
			get :recommend_playlist do
				result = Utils::Helper::get("#{ENV["QQ_MUSIC_URL"]}/recommend/playlist?id=#{params[:id]}&pageNo=#{params[:page]}&pageSize=#{params[:limit]}")

				data = []
				if result["result"] == 100
					result["data"]["list"].each do |item|
						object = {}
						object.store("dissid", item["tid"])
						object.store("dissname", item["title"])
						object.store("createtime", item["create_time"])
						object.store("commit_time", item["commit_time"])
						object.store("score", item["score"])
						object.store("imgurl", item["cover_url_big"])
						creator = {}
						creator.store("qq", item["creator_uin"])
						creator.store("name", item["creator_info"]["nick"])
						object.store("creator", creator)
						data.push(object)
					end

					return {:code => "0", :message => "SUCCESS", :data => data.as_json()}
				else
					return {:code => "1", :message => result["errMsg"]}
				end
			end

			desc "歌曲详情"
			params do
				requires :id, type: String, desc: "歌曲mid"
			end
			get :song_info do
				result = Utils::Helper::get("#{ENV["QQ_MUSIC_URL"]}/song?songmid=#{params[:id]}")

				if result["result"] == 100
					song = {}

					song.store("songMid", result["data"]["track_info"]["mid"])
					song.store("songId", result["data"]["track_info"]["id"])
					song.store("songType", result["data"]["track_info"]["type"])
					song.store("title", result["data"]["track_info"]["title"])
					song.store("subTitle", result["data"]["track_info"]["subtitle"])
					song.store("singer", result["data"]["track_info"]["singer"])
					song.store("time_public", result["data"]["track_info"]["time_public"])
					song.store("albumMid", result["data"]["track_info"]["album"]["mid"])
					song.store("albumId", result["data"]["track_info"]["album"]["id"])
					song.store("albumName", result["data"]["track_info"]["album"]["name"])
					song.store("albumDesc", result["data"]["track_info"]["album"]["subtitle"])
					song.store("albumUrl", "https://y.gtimg.cn/music/photo_new/T002R300x300M000#{result["data"]["track_info"]["album"]["mid"]}.jpg?max_age=2592000")
					song.store("vid", result["data"]["track_info"]["mv"]["vid"])
					song.store("strMediaMid", result["data"]["track_info"]["file"]["media_mid"])

					url_result = Utils::Helper::get("#{ENV["QQ_MUSIC_URL"]}/song/urls?id=#{params[:id]}")
					if url_result["result"] == 100
						url = url_result["data"]["#{params[:id]}"]

						song.store("url", url.gsub("http://124.89.197.18/amobile.music.tc.qq.com", "http://ws.stream.qqmusic.qq.com"))
					end

					lyric_result = Utils::Helper::get("#{ENV["QQ_MUSIC_URL"]}/lyric?songmid=#{params[:id]}")
					if lyric_result["result"] == 100
						song.store("lyric", lyric_result["data"]["lyric"])
						song.store("lyric_trans", lyric_result["data"]["trans"])
					end

					return {:code => "0", :message => "SUCCESS", :data => song.as_json()}
				else
					return {:code => "1", :message => result["errMsg"]}
				end
			end

			desc "歌手列表"
			params do
				optional :area, type: Integer, desc: "地区", default: -100
				optional :genre, type: Integer, desc: "风格", default: -100
				optional :index, type: Integer, desc: "首字母", default: -100
				optional :sex, type: Integer, desc: "性别", default: -100
				optional :page, type: Integer, desc: "页码", default: 1
			end
			get :singers do
				result = Utils::Helper::get("#{ENV["QQ_MUSIC_URL"]}/singer/list?area=#{params[:area]}&index=#{params[:index]}&genre=#{params[:genre]}&sex=#{params[:sex]}&pageNo=#{params[:page]}")
				if result["result"] == 100
					data = []
					result["data"]["list"].each do |item|
						object = {}
						object.store("id", item["singer_id"])
						object.store("mid", item["singer_mid"])
						object.store("name", item["singer_name"])
						object.store("pic", item["singer_pic"])
						data.push(object)
					end
					return {:code => "0", :message => "SUCCESS", :data => data.as_json()}
				else
					return {:code => "1", :message => result["errMsg"]}
				end
			end

			desc "相似歌手"
			params do
				requires :id, type: String, desc: "歌手ID"
			end
			get :singers_sim do
				result = Utils::Helper::get("#{ENV["QQ_MUSIC_URL"]}/singer/sim?singermid=#{params[:id]}")
				if result["result"] == 100
					return {:code => "0", :message => "SUCCESS", :data => result["data"]["list"].as_json()}
				else
					return {:code => "1", :message => result["errMsg"]}
				end
			end

			desc "歌手热门歌曲"
			params do
				requires :id, type: String, desc: "歌手ID"
			end
			get :singer_hot_song do
				result = Utils::Helper::get("#{ENV["QQ_MUSIC_URL"]}/singer/songs?singermid=#{params[:id]}")
				if result["result"] == 100
					data = []
					result["data"]["list"].each do |item|
						object = {}
						object.store("title", item["name"])
						object.store("songId", item["id"])
						object.store("songMid", item["mid"])
						object.store("songType", item["type"])
						object.store("vid", item["mv"]["vid"])
						object.store("albumMid", item["album"]["mid"])
						object.store("albumDesc", item["album"]["subtitle"])
						object.store("albumName", item["album"]["name"])
						object.store("albumId", "#{item["album"]["id"]}")
						object.store("albumUrl", "https://y.gtimg.cn/music/photo_new/T002R300x300M000#{item["album"]["mid"]}.jpg?max_age=2592000")
						object.store("singer", item["singer"])

						data.push(object)
					end
					return {:code => "0", :message => "SUCCESS", :data => data.as_json()}
				else
					return {:code => "1", :message => result["errMsg"]}
				end
			end

			desc "歌手mv"
			params do
				requires :id, type: String, desc: "歌手ID"
				optional :page, type: Integer, desc: "页码", default: 1
				optional :limit, type: Integer, desc: "每页条数", default: 20
			end
			get :singer_mv do
				result = Utils::Helper::get("#{ENV["QQ_MUSIC_URL"]}/singer/mv?singermid=#{params[:id]}&pageNo=#{params[:page]}&pageSize=#{params[:limit]}")
				if result["result"] == 100
					return {:code => "0", :message => "SUCCESS", :data => result["data"]["list"].as_json()}
				else
					return {:code => "1", :message => result["errMsg"]}
				end
			end

			desc "歌手专辑"
			params do
				requires :id, type: String, desc: "歌手ID"
				optional :page, type: Integer, desc: "页码", default: 1
				optional :limit, type: Integer, desc: "每页条数", default: 20
			end
			get :singer_album do
				result = Utils::Helper::get("#{ENV["QQ_MUSIC_URL"]}/singer/album?singermid=#{params[:id]}&pageNo=#{params[:page]}&pageSize=#{params[:limit]}")
				if result["result"] == 100
					result["data"]["list"].each do |item|
						item.store("company", item["company"]["company_name"])
						item.store("id", item["albumid"])
						item.store("mid", item["album_mid"])
						item.store("name", item["album_name"])
						item.store("publishTime", item["pub_time"])
						item.store("picUrl", "https://y.gtimg.cn/music/photo_new/T002R300x300M000#{item["album_mid"]}.jpg?max_age=2592000")

						item.delete("albumid")
						item.delete("album_mid")
						item.delete("album_name")
						item.delete("pub_time")
						item.delete("singer_id")
						item.delete("singer_name")
						item.delete("singer_mid")
					end

					return {:code => "0", :message => "SUCCESS", :data => result["data"]["list"].as_json()}
				else
					return {:code => "1", :message => result["errMsg"]}
				end
			end

			desc "专辑详情"
			params do
				requires :id, type: String, desc: "专辑ID"
			end
			get :album_info do
				result = Utils::Helper::get("#{ENV["QQ_MUSIC_URL"]}/album?albummid=#{params[:id]}")
				if result["result"] == 100
					album = result["data"]
					album.store("singers", result["data"]["ar"])
					album.delete("ar")

					songs_result = Utils::Helper::get("#{ENV["QQ_MUSIC_URL"]}/album/songs?albummid=#{params[:id]}")
					if songs_result["result"] == 100
						songs = []
						songs_result["data"]["list"].each do |item|
							object = {}
							object.store("title", item["name"])
							object.store("songId", item["id"])
							object.store("songMid", item["mid"])
							object.store("songType", item["type"])
							object.store("vid", item["mv"]["vid"])
							object.store("albumMid", item["album"]["mid"])
							object.store("albumDesc", item["album"]["subtitle"])
							object.store("albumName", item["album"]["name"])
							object.store("albumId", "#{item["album"]["id"]}")
							object.store("albumUrl", "https://y.gtimg.cn/music/photo_new/T002R300x300M000#{item["album"]["mid"]}.jpg?max_age=2592000")
							object.store("singer", item["singer"])

							songs.push(object)
						end

						album.store("songs", songs)

						return {:code => "0", :message => "SUCCESS", :data => album.as_json()}
					else
						return {:code => "1", :message => songs_result["errMsg"]}
					end
				else
					return {:code => "1", :message => result["errMsg"]}
				end
			end

    end
  end
end
