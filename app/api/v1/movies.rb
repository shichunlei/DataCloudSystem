module V1
	class Movies < Grape::API

		include Utils

		API_KEY = '0b2bdeda43b5688921839c8ecb20399b'
		BASE_URL = 'https://movie.douban.com'

		resource :movies do

			desc "首页数据"
			params do
        requires :city, type: String, desc: '城市'
      end
      get :home_data do
				city = params[:city]

				# Banner
				banners = []

				doc = Nokogiri::HTML(open("#{BASE_URL}"))
        doc.encoding = 'utf-8'

				list = doc.css('ul.ui-slide-content').css('li.ui-slide-item').css('div.gallery-frame')

				list.each do |item|
					news = {}
					news.store("cover", item.css('a').css('img').first['src'])
					# news.store("cover_w", item.css('a').css('img').first['width'])
					# news.store("cover_h", item.css('a').css('img').first['height'])
					news.store("link", item.css('a').first['href'])
					news.store("title", item.css('div.gallery-detail').css('div.gallery-hd').css('h3').text)
					news.store("summary", item.css('div.gallery-detail').css('div.gallery-bd').css('p').text.gsub(/[\n\r ]/, ""))

					banners.push(news)
				end

				# 热映
				in_theaters_result = Utils::Helper::get("#{ENV['DOUBAN_BASE_URL']}/in_theaters?city=#{city}&start=0&count=6&apikey=#{ENV['DOUBAN_KEY']}")

				in_theaters_result["subjects"].each do |item|
					item.delete("casts")
					item.delete("directors")
					item.delete("alt")
					item.delete("pubdates")
					item.delete("durations")
					item.delete("genres")
					item["rating"].delete("details")
				end

				# 即将上映
				soon_result = Utils::Helper::get("#{ENV['DOUBAN_BASE_URL']}/coming_soon?start=0&count=6&apikey=#{ENV['DOUBAN_KEY']}")

				soon_result["subjects"].each do |item|
					item.delete("casts")
					item.delete("directors")
					item.delete("alt")
					item.delete("pubdates")
					item.delete("durations")
					item.delete("genres")
					item["rating"].delete("details")
				end

				# top250
				top_result = Utils::Helper::get("#{ENV['DOUBAN_BASE_URL']}/top250?start=0&count=10&apikey=#{ENV['DOUBAN_KEY']}")
				tops = {}
				tops.store("tip", "豆瓣榜单~共250部")
				tops.store("title", top_result['title'])
				top_result["subjects"].each do |item|
					item.delete("casts")
					item.delete("directors")
					item.delete("alt")
					item.delete("pubdates")
					item.delete("durations")
					item.delete("genres")
					item["rating"].delete("details")
				end
				tops.store("subjects", top_result["subjects"])
				tops.store("has_more", true)

				# 新片榜
				new_result = Utils::Helper::get("#{ENV['DOUBAN_BASE_URL']}/new_movies?apikey=#{ENV['DOUBAN_KEY']}")
				news = {}
				news.store("tip", "每周五更新~共#{new_result["subjects"].size}部")
				news.store("title", new_result['title'])
				new_result["subjects"].each do |item|
					item.delete("casts")
					item.delete("directors")
					item.delete("alt")
					item.delete("pubdates")
					item.delete("durations")
					item.delete("genres")
					item["rating"].delete("details")
				end
				news.store("subjects", new_result["subjects"])
				news.store("has_more", false)

				# 北美票房榜
				uses = {}
				uses_result = []
				us_result = Utils::Helper::get("#{ENV['DOUBAN_BASE_URL']}/us_box?apikey=#{ENV['DOUBAN_KEY']}")
				us_result["subjects"].each do |item|
					item["subject"].delete("casts")
					item["subject"].delete("directors")
					item["subject"].delete("alt")
					item["subject"].delete("pubdates")
					item["subject"].delete("durations")
					item["subject"].delete("genres")
					item["subject"]["rating"].delete("details")
					uses_result.push(item["subject"])
				end
				uses.store("tip", "每周五更新~共#{uses_result.size}部")
				uses.store("title", us_result["title"])
				uses.store("subjects", uses_result)
				uses.store("has_more", false)

				# 本周口碑榜
				weekly = {}
				weekly_result = []
				_weekly_result = Utils::Helper::get("#{ENV['DOUBAN_BASE_URL']}/weekly?apikey=#{ENV['DOUBAN_KEY']}")
				_weekly_result["subjects"].each do |item|
					item["subject"].delete("casts")
					item["subject"].delete("directors")
					item["subject"].delete("alt")
					item["subject"].delete("pubdates")
					item["subject"].delete("durations")
					item["subject"].delete("genres")
					item["subject"]["rating"].delete("details")
					weekly_result.push(item["subject"])
				end
				weekly.store("tip", "每周五更新~共#{weekly_result.size}部")
				weekly.store("title", _weekly_result["title"])
				weekly.store("subjects", weekly_result)
				weekly.store("has_more", false)

				ranges = []
				ranges.push(weekly)
				ranges.push(news)
				ranges.push(uses)
				ranges.push(tops)

				# 分类
				category = Utils::Helper::get("#{BASE_URL}/j/search_tags?type=movie")

				search_subjects = []

				(0..2).each do |i|
					tag_result = Utils::Helper::get("#{BASE_URL}/j/search_subjects?type=movie&tag=#{category["tags"][i]}&page_limit=3&page_start=0")

					movie = {}
					movie.store("title", category["tags"][i])

					subjects = []
					tag_result['subjects'].each do |item|
						subject = {}
						subject.store("id", item["id"])
						subject.store("title", item["title"])

						image = {}
						image.store("small", item["cover"])
						image.store("large", item["cover"])
						image.store("medium", item["cover"])
						subject.store("images", image)

						subject.store("new", item["is_new"])
						subject.store("playable", item["playable"])
						# subject.store("alt", item["url"])
						subject.store("original_title", item["title"])

						rating = {}
						rating.store("average", item["rate"].to_f)
						# rating.store("value", item["rate"].to_f)
						rating.store("min", 0)
						rating.store("max", 10)

						subject.store("rating", rating)

						subjects.push(subject)
					end

					movie.store("subjects", subjects)

					search_subjects.push(movie)
				end

				data = {}

				data.store("banners", banners)
				data.store("in_theaters", in_theaters_result["subjects"])
				data.store("soon_movies", soon_result["subjects"])
				data.store("ranges", ranges)
				data.store("category", search_subjects)

				return {:code => 0, :message => "SUCCESS", :data => data.as_json()}
			end

			desc "正在上映"
			params do
        requires :page, type: Integer, desc: '页码'
				requires :limit, type: Integer, desc: '每页条数'
				requires :city, type: String, desc: '城市'
      end
      get :in_theaters do
        count = params[:limit]
				start = (params[:page] - 1) * count
				city = params[:city]

				result = Utils::Helper::get("#{ENV['DOUBAN_BASE_URL']}/in_theaters?apikey=#{ENV['DOUBAN_KEY']}&city=#{city}&start=#{start}&count=#{count}")

				return {:code => 0, :message => "SUCCESS", :data => result["subjects"].as_json()}
			end

			desc "即将上映"
			params do
        requires :page, type: Integer, desc: '页码'
				requires :limit, type: Integer, desc: '每页条数'
      end
      get :coming_soon do
        count = params[:limit]
				start = (params[:page] - 1) * count

				result = Utils::Helper::get("#{ENV['DOUBAN_BASE_URL']}/coming_soon?apikey=#{ENV['DOUBAN_KEY']}&start=#{start}&count=#{count}")

				return {:code => 0, :message => "SUCCESS", :data => result["subjects"].as_json()}
			end

			desc "新片榜"
			params do
      end
      get :new_movies do
				result = Utils::Helper::get("#{ENV['DOUBAN_BASE_URL']}/new_movies?apikey=#{ENV['DOUBAN_KEY']}")

				return {:code => 0, :message => "SUCCESS", :data => result["subjects"].as_json()}
			end

			desc "Top250"
			params do
				requires :page, type: Integer, desc: '页码'
				requires :limit, type: Integer, desc: '每页条数'
      end
      get :top250 do
				count = params[:limit]
				start = (params[:page] - 1) * count
				result = Utils::Helper::get("#{ENV['DOUBAN_BASE_URL']}/top250?apikey=#{ENV['DOUBAN_KEY']}&start=#{start}&count=#{count}")

				return {:code => 0, :message => "SUCCESS", :data => result["subjects"].as_json()}
			end

			desc "一周口碑榜"
			params do
      end
      get :weekly do
				result = Utils::Helper::get("#{ENV['DOUBAN_BASE_URL']}/weekly?apikey=#{ENV['DOUBAN_KEY']}")

				data = []

				result["subjects"].each do |item|
					item['subject'].store("rank", item['rank'])
					item['subject'].store("delta", item['delta'])
					data.push(item['subject'])
				end

				return {:code => 0, :message => "SUCCESS", :data => data.as_json()}
			end

			desc "北美票房榜"
			params do
      end
      get :us_box do
				result = Utils::Helper::get("#{ENV['DOUBAN_BASE_URL']}/us_box?apikey=#{ENV['DOUBAN_KEY']}")

				data = []

				result["subjects"].each do |item|
					item['subject'].store("rank", item['rank'])
					item['subject'].store("box", item['box'])
					item['subject'].store("new", item['new'])
					data.push(item['subject'])
				end

				return {:code => 0, :message => "SUCCESS", :data => data.as_json()}
			end

			desc "影片详情"
			params do
				requires :id, type: String, desc: 'ID'
      end
      get :details do
				id = params[:id]
				result = Utils::Helper::get("#{ENV['DOUBAN_BASE_URL']}/subject/#{id}?apikey=#{ENV['DOUBAN_KEY']}")

				return {:code => 0, :message => "SUCCESS", :data => result.as_json()}
			end

			desc "影评"
			params do
				requires :id, type: String, desc: 'ID'
				requires :page, type: Integer, desc: '页码'
				requires :limit, type: Integer, desc: '每页条数'
      end
      get :reviews do
				id = params[:id]
				count = params[:limit]
				start = (params[:page] - 1) * count

				result = Utils::Helper::get("#{ENV['DOUBAN_BASE_URL']}/subject/#{id}/reviews?apikey=#{ENV['DOUBAN_KEY']}&count=#{count}&start=#{start}")

				return {:code => 0, :message => "SUCCESS", :data => result['reviews'].as_json()}
			end

			desc "短评"
			params do
				requires :id, type: String, desc: 'ID'
				requires :page, type: Integer, desc: '页码'
				requires :limit, type: Integer, desc: '每页条数'
      end
      get :comments do
				id = params[:id]
				count = params[:limit]
				start = (params[:page] - 1) * count

				result = Utils::Helper::get("#{ENV['DOUBAN_BASE_URL']}/subject/#{id}/comments?apikey=#{ENV['DOUBAN_KEY']}&count=#{count}&start=#{start}")

				return {:code => 0, :message => "SUCCESS", :data => result['comments'].as_json()}
			end

			desc "剧照"
			params do
				requires :id, type: String, desc: 'ID'
				requires :type, type: String, desc: '类型'
				requires :page, type: Integer, desc: '页码'
				requires :limit, type: Integer, desc: '每页条数'
      end
      get :photos do
				id = params[:id]
				start = (params[:page] - 1) * params[:limit]
				count = start + params[:limit]
				type = params[:type]

				if type == "subject" || type == "celebrity"
					result = Utils::Helper::get("#{ENV['DOUBAN_BASE_URL']}/#{type}/#{id}/photos?apikey=#{ENV['DOUBAN_KEY']}&count=#{count}&start=#{start}")
					return {:code => 0, :message => "SUCCESS", :data => result['photos'].as_json()}
				else
					return {:code => -1, :message => "请求错误"}
				end
			end

			desc "影片剧照"
			params do
				requires :id, type: String, desc: 'ID'
				requires :page, type: Integer, desc: '页码'
				requires :limit, type: Integer, desc: '每页条数'
      end
      get :movie_photos do
				id = params[:id]
				start = (params[:page] - 1) * params[:limit]
				count = start + params[:limit]

				result = Utils::Helper::get("#{ENV['DOUBAN_BASE_URL']}/subject/#{id}/photos?apikey=#{ENV['DOUBAN_KEY']}&count=#{count}&start=#{start}")

				return {:code => 0, :message => "SUCCESS", :data => result['photos'].as_json()}
			end

			desc "影人详情"
			params do
				requires :id, type: String, desc: 'ID'
      end
      get :celebrity do
				id = params[:id]
				result = Utils::Helper::get("#{ENV['DOUBAN_BASE_URL']}/celebrity/#{id}?apikey=#{ENV['DOUBAN_KEY']}")

				return {:code => 0, :message => "SUCCESS", :data => result.as_json()}
			end

			desc "影人剧照"
			params do
				requires :id, type: String, desc: 'ID'
				requires :page, type: Integer, desc: '页码'
				requires :limit, type: Integer, desc: '每页条数'
      end
      get :celebrity_photos do
				id = params[:id]
				start = (params[:page] - 1) * params[:limit]
				count = start + params[:limit]

				result = Utils::Helper::get("#{ENV['DOUBAN_BASE_URL']}/celebrity/#{id}/photos?apikey=#{ENV['DOUBAN_KEY']}&count=#{count}&start=#{start}")

				return {:code => 0, :message => "SUCCESS", :data => result['photos'].as_json()}
			end

			desc "影人作品"
			params do
				requires :id, type: String, desc: 'ID'
				requires :page, type: Integer, desc: '页码'
				requires :limit, type: Integer, desc: '每页条数'
      end
      get :works do
				id = params[:id]
				count = params[:limit]
				start = (params[:page] - 1) * count

				result = Utils::Helper::get("#{ENV['DOUBAN_BASE_URL']}/celebrity/#{id}/works?apikey=#{ENV['DOUBAN_KEY']}&count=#{count}&start=#{start}")

				data = []
				result['works'].each do |item|
					item["subject"].store("roles", item["roles"])
					data.push(item["subject"])
				end

				return {:code => 0, :message => "SUCCESS", :data => data.as_json()}
			end

			desc "影视筛选"
			params do
        requires :page, type: Integer, desc: '页码'
        requires :range, type: String, desc: '评分区间' # 默认 0,10 用逗号,隔开
				requires :sort, type: String, desc: '排序方式' # U 近期热门（默认）；T 标签数量；S 评分；R 最新上映
				optional :type, type: String, desc: '形式' # 电影 电视剧 综艺 动漫 纪录片 短片
				optional :feature, type: String, desc: '特色' # 放在tags后面用逗号,隔开，多个特色也可用逗号,隔开
				optional :genres, type: String, desc: '类型' # 喜剧 动作 爱情 科幻 动画 悬疑 惊悚 恐怖 犯罪 同性 音乐 歌舞 传记 历史 战争 西部 奇幻 冒险 灾难 武侠 情色
				optional :countries, type: String, desc: '地区' # 中国大陆 美国 中国香港 中国台湾 日本 韩国 英国 法国 德国 意大利 西班牙 印度 泰国 俄罗斯 伊朗 加拿大 澳大利亚 爱尔兰 瑞典 巴西 丹麦
				optional :year_range, type: String, desc: '类型' # 2019 2018 2010年代 2000年代 90年代 80年代70年代 60年代 更早
				optional :playable, type: Integer, desc: '是否可播放' # 1 或 空
				optional :unwatched, type: Integer, desc: '我没看过' # 1 或 空
      end
      get :screening do
				_params = declared(params)
				_params.delete_if{|k, v| v.blank? }
				_params.store("start", (_params['page'] - 1)  * 20)
				_params.delete('page')
				if _params.include?('type') || _params.include?('feature')
					if _params.include?('type') && _params.include?('feature')
						_params.store('tags', "#{_params['type']},#{_params['feature']}")
					else
						if _params.include?('type')
							_params.store('tags', "#{_params['type']}")
						end
						if _params.include?('feature')
							_params.store('tags', "#{_params['feature']}")
						end
					end
				end
				_params.delete('type')
				_params.delete('feature')

				url = "#{BASE_URL}/j/new_search_subjects?"

				_params.each do |k, v|
					url += "#{k}=#{v}&"
				end

				result = Utils::Helper::get(url)

				subjects = []
				result["data"].each do |item|
					subject = {}
					subject.store("id", item["id"])
					subject.store("title", item["title"])

					image = {}
					image.store("small", item["cover"])
					image.store("large", item["cover"])
					image.store("medium", item["cover"])
					subject.store("images", image)

					# subject.store("alt", item["url"])
					subject.store("original_title", item["title"])

					rating = {}
					rating.store("average", item["rate"].to_f)
					rating.store("stars", item["star"].to_i)
					rating.store("min", 0)
					rating.store("max", 10)

					subject.store("rating", rating)

					directors = []
					item["directors"].each do |item|
						director = {}
						director.store("name", item)

						directors.push(director)
					end
					subject.store("directors", directors)

					casts = []
					item["casts"].each do |item|
						cast = {}
						cast.store("name", item)

						casts.push(cast)
					end
					subject.store("casts", casts)

					subjects.push(subject)
				end

				return {:code => 0, :message => "SUCCESS", :data => subjects}
			end

    end
  end
end
