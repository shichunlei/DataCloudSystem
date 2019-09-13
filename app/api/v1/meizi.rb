module V1
	class Meizi < Grape::API
		resource :meizi do

      desc "最新/最热/推荐"
      params do
        requires :page, type: Integer, desc: '页码'
        requires :type, type: String, desc: '类型'
      end
      get :list do
        page = params[:page]
        type = params[:type]

        if page == 1
          doc = Nokogiri::HTML(open("https://www.mzitu.com/#{type}/"))
        else
          doc = Nokogiri::HTML(open("https://www.mzitu.com/#{type}/page/#{page}/"))
        end
        doc.encoding = 'utf-8'

        list = doc.css('div.main').css('div.main-content').css('div.postlist').css('ul').css("li")

        meizis = []

        list.each do |li|
          meizi = {}
          id = li.css('a').first['href'].gsub('https://www.mzitu.com/', '')
          meizi.store("id", id)
          puts id
          image = li.css('a').css("img.lazy").first['data-original']
          puts image
          meizi.store("image", image)
          title = li.css('span')[0].css('a').text
          puts title
          meizi.store("title", title)
          time = li.css('span.time').text
          puts time
          meizi.store("time", time)
          view = li.css('span.view').text.gsub('次', '').gsub(',', '')
          puts view
          meizi.store("view", view)

          meizis.push(meizi)
        end
        return {"code" => 0, "message" => "SUCCESS", :data => meizis.as_json()}
      end

      desc "专题(视觉、妹子、名站写真)列表"
      params do
      end
      get :zhuanti do
        doc = Nokogiri::HTML(open("https://www.mzitu.com/zhuanti/"))
        doc.encoding = 'utf-8'

        list = doc.css('div.main').css('div.main-content').css('div.postlist').css('dl.tags').css('dd')

        data = {}
        meizis = []

        list.each do |dd|
          id = dd.css('a').first['href'].gsub('https://www.mzitu.com/tag/','').gsub('/','')
          puts id
          image = dd.css('a').css("img").first['data-original']
          puts image
          title = dd.css('a').text
          puts title
          number = dd.css('i').text.gsub('共','').gsub('套图','')
          puts number

          meizi = {}
          meizi.store("id", id)
          meizi.store("number", number)
          meizi.store("title", title)
          meizi.store("image", image)

          meizis.push(meizi)
        end

        return {"code" => 0, "message" => "SUCCESS", :data => meizis.as_json()}
      end

      desc "自拍"
      params do
        requires :page, type: Integer, desc: '页码'
      end
      get :zipai do
        page = params[:page]

        doc = Nokogiri::HTML(open("https://www.mzitu.com/zipai/comment-page-#{page}/#comments"))
        doc.encoding = 'utf-8'

        list = doc.css('div.main').css('div.main-content').css('div.postlist').css('div').css('ul').css("li.comment")

        meizis = []

        list.each do |li|
          image = li.css('div.comment-body').css('p').css("img").first['src']
          puts image
          time = li.css('div.comment-body').css("div.comment-meta").css('a').text.gsub('/\n','').gsub('/\t','')
          puts time

          meizi = {}
          meizi.store("image", image)
          meizi.store("time", time)

          meizis.push(meizi)
        end

        return {"code" => 0, "message" => "SUCCESS", :data => meizis.as_json()}
      end

      desc "搜索"
      params do
        requires :page, type: Integer, desc: '页码'
        requires :keyword, type: String, desc: '关键字'
      end
      post :search do
        page = params[:page]
        keyword = params[:keyword]

        url = URI::encode("https://www.mzitu.com/search/#{keyword}/page/#{page}/")
        doc = Nokogiri::HTML(open(url))
        doc.encoding = 'utf-8'
        list = doc.css('div.main').css('div.main-content').css('div.postlist').css('ul').css("li")

        meizis = []
        list.each do |li|
          meizi = {}
          id = li.css('a').first['href'].gsub('https://www.mzitu.com/', '')
          meizi.store("id", id)
          puts id
          image = li.css('a').css("img.lazy").first['data-original']
          puts image
          meizi.store("image", image)
          title = li.css('span')[0].css('a').text
          puts title
          meizi.store("title", title)
          time = li.css('span.time').text
          puts time
          meizi.store("time", time)
          view = li.css('span.view').text.gsub('次', '').gsub(',', '')
          puts view
          meizi.store("view", view)

          meizis.push(meizi)
        end

        return {"code" => 0, "message" => "SUCCESS", :data => meizis.as_json()}
      end

      desc "图集图片"
      params do
        requires :id, type: Integer, desc: '图集ID'
      end
      get :info do
        id = params[:id]

        doc = Nokogiri::HTML(open("https://www.mzitu.com/#{id}"))
        doc.encoding = 'utf-8'

        meizis = []
        meizi = {}
        content = doc.css('div.main').css('div.content')
        title = content.css('h2.main-title').text
        puts title
        meizi.store("title", title)
        classify = content.css("div.main-meta").css('span')[0].css('a').text
        puts classify
        meizi.store("classify", classify)
        time = content.css("div.main-meta").css('span')[1].text
        puts time
        meizi.store("time", time)
        number = content.css("div.main-meta").css('span')[2].text
        puts number
        meizi.store("number", number)
        image = content.css('div.main-image').css('p').css('a').css('img').first['src']
        puts image
        meizi.store("image", image)
        meizis.push(meizi)

        page = doc.css('div.main').css('div.content').css('div.pagenavi').css('a')[4].css('span').text

        (2..page.to_i).each do |p|
          doc = Nokogiri::HTML(open("https://www.mzitu.com/#{id}/#{p}/"))
          doc.encoding = 'utf-8'
          if doc.at('.//div[@class="main"]')
            meizi = {}
            content = doc.css('div.main').css('div.content')
            title = content.css('h2.main-title').text
            puts title
            meizi.store("title", title)
            classify = content.css("div.main-meta").css('span')[0].css('a').text
            puts classify
            meizi.store("classify", classify)
            time = content.css("div.main-meta").css('span')[1].text
            puts time
            meizi.store("time", time)
            number = content.css("div.main-meta").css('span')[2].text
            puts number
            meizi.store("number", number)
            image = content.css('div.main-image').css('p').css('a').css('img').first['src']
            puts image
            meizi.store("image", image)
            meizis.push(meizi)
          end
        end

        return {"code" => 0, "message" => "SUCCESS", :data => meizis.as_json()}
      end

    end
  end
end
