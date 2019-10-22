module V1
	class Juzimi < Grape::API

		include Utils

		resource :juzimi do

      desc "句子迷分类列表"
      params do
        requires :page, type: Integer, desc: '页码'
        requires :type, type: String, desc: '类型' # 爱情 - aiqing；励志 - lizhi；伤感 - shanggan；正能量 - zhengnl
      end
      get :list do
        page = params[:page]
        type = params[:type]

        doc = Nokogiri::HTML(open("http:#{ENV['JUZIMI_BASE_URL']}#{type}/index_#{page}.html"))
        doc.encoding = 'utf-8'

        list = doc.css('section.main').css('section.news-list-module').css('article.item')

        _juzimi = []

        list.each do |li|
          juzimi = {}
          id = li.css('section.news-img').css('a').first['href'].gsub(/[.\/a-z]/, '')
          juzimi.store("id", id.to_i)
          image = li.css('section.news-img').css('a').css("img.img").first['src']
          if !image.include? 'http'
            image = "http://www.cnjxn.com#{image}"
          end
          juzimi.store("image", image)
          title = li.css('section.news-detail').css('p.title').css('a').text
          juzimi.store("title", title)
          time = li.css('section.news-detail').css('section.author').css('span.time').text
          juzimi.store("time", time)
          desc = li.css('section.news-detail').css('p.desc').text
          juzimi.store("desc", desc)
          type_name = li.css('section.column-name').css('a').css('span.name').text
          juzimi.store("type_name", type_name)
					type = li.css('section.column-name').css('a').first['href'].gsub("#{ENV['JUZIMI_BASE_URL']}", '').gsub('/', '')
          juzimi.store("type", type)
          comment_count = li.css('section.comment').css('a').css('span.count').text
          juzimi.store("comment_count", comment_count.to_i)
          tags = []
          _tags = li.css('section.news-detail').css('section.author').css('span')[0].css('a')
					_tags.each do |tag|
						_tag = {}
						_tag.store('id', tag['href'].gsub(/[.\/a-z]/, '').to_i)
						_tag.store('tag', tag.text)

						tags.push(_tag)
					end
          juzimi.store("tags", tags)

          _juzimi.push(juzimi)
        end
        return {"code" => 0, "message" => "SUCCESS", :data => _juzimi.as_json()}
      end

			desc "句子迷标签列表"
      params do
        requires :page, type: Integer, desc: '页码'
        requires :tag_id, type: Integer, desc: '标签ID'
      end
      get :tag_list do
        page = params[:page]
        tag_id = params[:tag_id]

        doc = Nokogiri::HTML(open("http:#{ENV['JUZIMI_BASE_URL']}tags/#{tag_id}_#{page}.html"))
        doc.encoding = 'utf-8'

        list = doc.css('section.main').css('section.news-list-module').css('article.item')

        _juzimi = []

        list.each do |li|
          juzimi = {}
          id = li.css('section.news-img').css('a').first['href'].gsub(/[.\/a-z]/, '')
          juzimi.store("id", id.to_i)
          image = li.css('section.news-img').css('a').css("img.img").first['src']
          if !image.include? 'http'
            image = "http://www.cnjxn.com#{image}"
          end
          juzimi.store("image", image)
          title = li.css('section.news-detail').css('p.title').css('a').text
          juzimi.store("title", title)
          time = li.css('section.news-detail').css('section.author').css('span.time').text
          juzimi.store("time", time)
          desc = li.css('section.news-detail').css('p.desc').text
          juzimi.store("desc", desc)
					type_name = li.css('section.column-name').css('a').css('span.name').text
          juzimi.store("type_name", type_name)
					type = li.css('section.column-name').css('a').first['href'].gsub("#{ENV['JUZIMI_BASE_URL']}", '').gsub('/', '')
          juzimi.store("type", type)
          comment_count = li.css('section.comment').css('a').css('span.count').text
          juzimi.store("comment_count", comment_count.to_i)
          tags = []
          _tags = li.css('section.news-detail').css('section.author').css('span')[0].css('a')
					_tags.each do |tag|
						_tag = {}
						_tag.store('id', tag['href'].gsub(/[.\/a-z]/, '').to_i)
						_tag.store('tag', tag.text)

						tags.push(_tag)
					end
          juzimi.store("tags", tags)

          _juzimi.push(juzimi)
        end
        return {"code" => 0, "message" => "SUCCESS", :data => _juzimi.as_json()}
      end

			desc "句子详情"
      params do
        requires :id, type: Integer, desc: '文章ID'
				requires :type, type: String, desc: '分类'
      end
      get :details do
        id = params[:id]
				type = params[:type]

        doc = Nokogiri::HTML(open("http:#{ENV['JUZIMI_BASE_URL']}#{type}/#{id}.html"))
        doc.encoding = 'utf-8'

				info = doc.css('section.article-row')

				header = info.css('section.article-title')

				title = header.css('p').text
				time = header.css('span')[0].text.gsub('发布时间：', '')
				source = header.css('span')[1].text.gsub('来源：', '')
				read_count = header.css('span')[2].text.gsub('阅读量：', '').to_i

				main = info.css('section.article-main').css('section.main')

				# 标签
				tags = []
				_tags = main.css('section.tags').css('a')
				_tags.each do |tag|
					_tag = {}
					_tag.store('id', tag['href'].gsub(/[.\/a-z]/, '').to_i)
					_tag.store('tag', tag.text)

					tags.push(_tag)
				end

				# 版权
				copyright = main.css('section.contribute-contact').css('p').text

				# 详情
				details = main.css('article p').to_s.gsub('/storage', "http:#{ENV['JUZIMI_BASE_URL']}storage")

				recommend = info.css('aside.recommend').css('section.scroll')

				# 推荐
				_recommends = recommend.css('section.news-list').css('section.item')

				recommends = []
				_recommends.each do |item|
					__juzimi = {}
					id = item.css('a').first['href'].gsub(/[.\/a-z]/, '')
					__juzimi.store('id', id.to_i)
					title = item.css('a').text
					__juzimi.store('title', title)
					type = item.css('a').first['href'].gsub("#{ENV['JUZIMI_BASE_URL']}", '').gsub('.html', '').gsub(/[0-9\/]/, '')
					__juzimi.store('type', type)
					time = item.css('span.author').text
					__juzimi.store('time', time.gsub(/[\n\r ]/, ''))

					recommends.push(__juzimi)
				end

				# 用户还喜欢
				_user_like = recommend.css('section.wire-push').css('section.wire-list').css('ul').css('li')

				user_like_tags = []
				_user_like.each do |item|
					puts item
					tag = {}

					tag.store('id', item.css('a').first['href'].gsub(/[.\/a-z]/, '').to_i)
					tag.store('tag', item.css('a').text)

					user_like_tags.push(tag)
				end

				# 同作者句子
				_author_news = main.css('section.author-news').css('section.news-list').css('ul').css('li')

				author_news = []
				_author_news.each do |item|
					__juzimi = {}
					id = item.css('a').first['href'].gsub(/[.\/a-z]/, '')
					__juzimi.store('id', id.to_i)
					title = item.css('a').text
					__juzimi.store('title', title)
					type = item.css('a').first['href'].gsub("#{ENV['JUZIMI_BASE_URL']}", '').gsub('.html', '').gsub(/[0-9\/]/, '')
					__juzimi.store('type', type)

					author_news.push(__juzimi)
				end

				juzimi = {}
				juzimi.store('id', id.to_i)
				juzimi.store('title', title)
				juzimi.store('time', time.gsub(/[\n\r ]/, ''))
				juzimi.store('source', source)
				juzimi.store('read_count', read_count)
				juzimi.store('tags', tags)
				juzimi.store('copyright', copyright)
				juzimi.store('details', details)
				juzimi.store('recommends', recommends)
				juzimi.store('user_like_tags', user_like_tags)
				juzimi.store('author_news', author_news)

        return {"code" => 0, "message" => "SUCCESS", :data => juzimi.as_json()}
      end

			desc "每日一文-今天"
			params do
      end
      get :article_today do
				result = Utils::Helper::get("#{ENV['ARTICLE_BASE_URL']}/article/today")

				puts result.to_json

				data = {}
				data = result["data"]
				data.store("id", result["data"]["wc"])
				data.store("curr", Utils::Helper::format_datetime(result["data"]["date"]["curr"], format = "%Y-%m-%d"))
				data.store("next", Utils::Helper::format_datetime(result["data"]["date"]["next"], format = "%Y-%m-%d"))
				data.store("prev", Utils::Helper::format_datetime(result["data"]["date"]["prev"], format = "%Y-%m-%d"))
				data.delete("wc")
				data.delete("date")

				return {:code => 0, :message => "SUCCESS", :data => data}
			end

			desc "每日一文-随机"
			params do
      end
      get :article_random do
				result = Utils::Helper::get("#{ENV['ARTICLE_BASE_URL']}/article/random")

				puts result.to_json

				data = {}
				data = result["data"]
				data.store("id", result["data"]["wc"])
				data.store("curr", Utils::Helper::format_datetime(result["data"]["date"]["curr"], format = "%Y-%m-%d"))
				data.store("next", Utils::Helper::format_datetime(result["data"]["date"]["next"], format = "%Y-%m-%d"))
				data.store("prev", Utils::Helper::format_datetime(result["data"]["date"]["prev"], format = "%Y-%m-%d"))
				data.delete("wc")
				data.delete("date")

				return {:code => 0, :message => "SUCCESS", :data => data}
			end

			desc "每日一文-特定日期"
			params do
				requires :date, type: String, desc: '日期'
      end
      get :article_day do
				date = params[:date].gsub('-', '')

				result = Utils::Helper::get("#{ENV['ARTICLE_BASE_URL']}/article/day?date=#{date}")

				puts result.to_json

				data = {}
				data = result["data"]
				data.store("id", result["data"]["wc"])
				data.store("curr", Utils::Helper::format_datetime(result["data"]["date"]["curr"], format = "%Y-%m-%d"))
				data.store("next", Utils::Helper::format_datetime(result["data"]["date"]["next"], format = "%Y-%m-%d"))
				data.store("prev", Utils::Helper::format_datetime(result["data"]["date"]["prev"], format = "%Y-%m-%d"))
				data.delete("wc")
				data.delete("date")

				return {:code => 0, :message => "SUCCESS", :data => data}
			end

    end
  end
end
