module V1
	class Astros < Grape::API

		include Utils

		resource :astros do

      desc "星座列表"
      params do
      end
      get :list do
        list = Astro.order(:id)
        return {"code" => 20001, "message" => "请求成功", :result => list.as_json(:except => [:created_at, :updated_at])}
      end

      desc "星座今日运势"
      params do
        requires :astro_id, type: Integer, desc: '星座ID'
      end
      get :fortune_details do
        astro_id = params[:astro_id]
        object = Astro.find_by(id:astro_id)
        return {"code" => 20001, "message" => "请求成功", :result => object.as_json(:methods => [:today_fortune, :tomorrow_fortune, :week_fortune, :month_fortune, :year_fortune], :except => [:created_at, :updated_at])}
      end

      desc "星座指定日期运势" # 目前支持自2016年1月1日至2018年6月30日
      params do
        requires :astro_id, type: Integer, desc: '星座ID'
        requires :select_date, type: String, desc: '指定日期'
      end
      get :_fortune_details do
        astro_id = params[:astro_id]
        select_date = params[:select_date]
        _date = Date.parse(select_date)
        today_fortune = TodayFortune.find_by(astro_id:astro_id, tdate:select_date)
        if today_fortune.nil?
          url = URI.parse("#{ENV['JISHU_URL']}/astro/fortune")

          params = {:appkey => ENV['ASTRO_APP_KEY'], :astroid => astro_id, :date => select_date}

          res = Net::HTTP.post_form(url, params)

          # 解析数据
          result = JSON.parse(res.body)

          puts "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

          puts "status = #{result["status"]}"
          puts "msg = #{result["msg"]}"

          puts "========================================================================"
          if result["status"] == '0'
            object = result["result"]
            year_fortune = object["year"]

            yearF = YearFortune.find_by(year:year_fortune["date"], astro_id:astro_id)
            if yearF.nil?
              yearF = YearFortune.new
              yearF.year = year_fortune["date"]
              yearF.summary = year_fortune["summary"]
              yearF.career = year_fortune["career"]
              yearF.money = year_fortune["money"]
              yearF.love = year_fortune["love"]
              yearF.astro_id = astro_id
              yearF.save
            else
              puts "年运势存在"
            end

            month_fortune = object["month"]

            month_f = MonthFortune.find_by(mdate:month_fortune["date"], astro_id:astro_id)
            if month_f.nil?
              month_f = MonthFortune.new
              month_f.mdate = month_fortune["date"]
              month_f.summary = month_fortune["summary"]
              month_f.money = month_fortune["money"]
              month_f.career = month_fortune["career"]
              month_f.love = month_fortune["love"]
              month_f.health = month_fortune["health"]
              month_f.astro_id = astro_id
              month_f.save
            else
              puts "月运势存在"
            end

            week_fortune = object["week"]

            arr = week_fortune["date"].split("~")
            start_date = arr[0]
            end_date = "#{_date.year}-#{arr[1]}"

            week_f = WeekFortune.find_by(start_date:start_date, end_date:end_date, astro_id:astro_id)
            if week_f.nil?
              week_f = WeekFortune.new
              week_f.start_date = start_date
              week_f.end_date = end_date
              week_f.job = week_fortune["job"]
              week_f.money = week_fortune["money"]
              week_f.career = week_fortune["career"]
              week_f.love = week_fortune["love"]
              week_f.health = week_fortune["health"]
              week_f.astro_id = astro_id
              week_f.save
            else
              puts "周运势存在"
            end

            tomorrow_fortune = object["tomorrow"]

            tomorrow_f = TomorrowFortune.find_by(tdate:tomorrow_fortune["date"], astro_id:astro_id)
            if tomorrow_f.nil?
              tomorrow_f = TomorrowFortune.new
              tomorrow_f.tdate = tomorrow_fortune["date"]
              tomorrow_f.presummary = tomorrow_fortune["presummary"]
              tomorrow_f.star = tomorrow_fortune["star"]
              tomorrow_f.color = tomorrow_fortune["color"]
              tomorrow_f.number = tomorrow_fortune["number"]
              tomorrow_f.summary = tomorrow_fortune["summary"]
              tomorrow_f.money = tomorrow_fortune["money"]
              tomorrow_f.career = tomorrow_fortune["career"]
              tomorrow_f.love = tomorrow_fortune["love"]
              tomorrow_f.health = tomorrow_fortune["health"]
              tomorrow_f.astro_id = astro_id
              tomorrow_f.save
            else
              puts "明日运势存在"
            end

            today_fortune = object["today"]

            today_f = TodayFortune.find_by(tdate:today_fortune["date"], astro_id:astro_id)
            if today_f.nil?
              today_f = TodayFortune.new
              today_f.tdate = today_fortune["date"]
              today_f.presummary = today_fortune["presummary"]
              today_f.star = today_fortune["star"]
              today_f.color = today_fortune["color"]
              today_f.number = today_fortune["number"]
              today_f.summary = today_fortune["summary"]
              today_f.money = today_fortune["money"]
              today_f.career = today_fortune["career"]
              today_f.love = today_fortune["love"]
              today_f.health = today_fortune["health"]
              today_f.astro_id = astro_id
              today_f.save
            else
              puts "今日运势存在"
            end
          end
        end

        object = Astro.find_by(id:astro_id).as_json(:except => [:created_at, :updated_at])
        data = object.to_h
        tomorrow_fortune = TomorrowFortune.find_by(astro_id:astro_id, tdate:(_date + 1))
        week_fortune = WeekFortune.find_by("astro_id = ? AND start_date <= ? AND end_date >= ?", astro_id, select_date, select_date)
        month = "#{_date.year}-#{_date.month}"
        month_fortune = MonthFortune.find_by(astro_id:astro_id, mdate:month)
        year_fortune = YearFortune.find_by(astro_id:astro_id, year:_date.year)
        data.store("today_fortune", today_fortune.as_json(:except => [:created_at, :updated_at, :astro_id]))
        data.store("tomorrow_fortune", tomorrow_fortune.as_json(:except => [:created_at, :updated_at, :astro_id]))
        data.store("week_fortune", week_fortune.as_json(:except => [:created_at, :updated_at, :astro_id]))
        data.store("month_fortune", month_fortune.as_json(:except => [:created_at, :updated_at, :astro_id]))
        data.store("year_fortune", year_fortune.as_json(:except => [:created_at, :updated_at, :astro_id]))
        return {"code" => 20001, "message" => "请求成功", :result => data}
      end

			desc "猜成语"
			params do
      end
      get :caichengyu do
				result = Utils::Helper::get("#{ENV['TIAN_BASE_URL']}/txapi/caichengyu/?key=#{ENV['TIAN_KEY']}")

				return {:code => 0, :message => result["msg"], :data => result["newslist"][0].as_json()}
			end

			desc "成语接龙"
			params do
				requires :word, type: String, desc: '成语'
				requires :userid, type: String, desc: '用户唯一识别码'
				requires :statetime, type: String, desc: '状态维持时间，单位秒，默认1800'
      end
      get :chengyujielong do
				statetime = params[:statetime]
				word = params[:word]
				userid = params[:userid]

				result = Utils::Helper::get("#{ENV['TIAN_BASE_URL']}/txapi/chengyujielong/?key=#{ENV['TIAN_KEY']}&word=#{word}&userid=#{userid}&statetime=#{statetime}")

				return {:code => 0, :message => result["msg"], :data => result["newslist"][0].as_json()}
			end

			desc "故事大全"
			params do
      end
      get :story do
				result = Utils::Helper::get("#{ENV['TIAN_BASE_URL']}/txapi/story/?key=#{ENV['TIAN_KEY']}")

				return {:code => 0, :message => result["msg"], :data => result["newslist"][0].as_json()}
			end

			desc "土味情话"
			params do
      end
      get :saylove do
				result = Utils::Helper::get("#{ENV['TIAN_BASE_URL']}/txapi/saylove/?key=#{ENV['TIAN_KEY']}")

				return {:code => 0, :message => result["msg"], :data => result["newslist"][0].as_json()}
			end

			desc "一站到底"
			params do
      end
      get :wenda do
				result = Utils::Helper::get("#{ENV['TIAN_BASE_URL']}/txapi/wenda/?key=#{ENV['TIAN_KEY']}")

				return {:code => 0, :message => result["msg"], :data => result["newslist"][0].as_json()}
			end

			desc "英语一句话"
			params do
      end
      get :ensentence do
				result = Utils::Helper::get("#{ENV['TIAN_BASE_URL']}/txapi/ensentence/?key=#{ENV['TIAN_KEY']}")

				return {:code => 0, :message => result["msg"], :data => result["newslist"][0].as_json()}
			end

			desc "优美诗句"
			params do
				requires :word, type: String, desc: '搜索词，来源或作者'
				requires :page, type: Integer, desc: '页码'
				requires :num, type: Integer, desc: '每页条数'
      end
      get :verse do
				word = params[:word]
				page = params[:page]
				num = params[:num]

				result = Utils::Helper::get("#{ENV['TIAN_BASE_URL']}/txapi/verse/?key=#{ENV['TIAN_KEY']}&word=#{word}&page=#{page}&num=#{num}")

				return {:code => 0, :message => result["msg"], :data => result["newslist"].as_json()}
			end

			desc "唐诗大全"
			params do
				requires :word, type: String, desc: '搜索词，来源或作者'
				requires :page, type: Integer, desc: '页码'
				requires :num, type: Integer, desc: '每页条数'
      end
      get :poetries do
				word = params[:word]
				page = params[:page]
				num = params[:num]

				result = Utils::Helper::get("#{ENV['TIAN_BASE_URL']}/txapi/poetries/?key=#{ENV['TIAN_KEY']}&word=#{word}&page=#{page}&num=#{num}")

				return {:code => 0, :message => result["msg"], :data => result["newslist"].as_json()}
			end

			desc "唐诗三百首"
			params do
				requires :word, type: String, desc: '搜索词，来源或作者'
				requires :page, type: Integer, desc: '页码'
				requires :num, type: Integer, desc: '每页条数'
      end
      get :poetry do
				word = params[:word]
				page = params[:page]
				num = params[:num]

				result = Utils::Helper::get("#{ENV['TIAN_BASE_URL']}/txapi/poetry/?key=#{ENV['TIAN_KEY']}&word=#{word}&page=#{page}&num=#{num}")

				return {:code => 0, :message => result["msg"], :data => result["newslist"].as_json()}
			end

			desc "精选宋词"
			params do
				requires :word, type: String, desc: '搜索词，来源或作者'
				requires :page, type: Integer, desc: '页码'
				requires :num, type: Integer, desc: '每页条数'
      end
      get :songci do
				word = params[:word]
				page = params[:page]
				num = params[:num]

				result = Utils::Helper::get("#{ENV['TIAN_BASE_URL']}/txapi/songci/?key=#{ENV['TIAN_KEY']}&word=#{word}&page=#{page}&num=#{num}")

				return {:code => 0, :message => result["msg"], :data => result["newslist"].as_json()}
			end

			desc "姓氏起源"
			params do
				requires :word, type: String, desc: '搜索词，来源或作者'
      end
      get :surname do
				xing = params[:word]

				result = Utils::Helper::get("#{ENV['TIAN_BASE_URL']}/txapi/surname/?key=#{ENV['TIAN_KEY']}&xing=#{xing}")

				return {:code => 0, :message => result["msg"], :data => result["newslist"].as_json()}
			end

			desc "西游记图鉴"
			params do
      end
      get :xiyouji do
				json = [{"url":"http://p1.pstatp.com/origin/pgc-image/3bb912eca5e743c98723f89673b3ee89","width":400,"url_list":[{"url":"http://p1.pstatp.com/origin/pgc-image/3bb912eca5e743c98723f89673b3ee89"},{"url":"http://pb3.pstatp.com/origin/pgc-image/3bb912eca5e743c98723f89673b3ee89"},{"url":"http://pb9.pstatp.com/origin/pgc-image/3bb912eca5e743c98723f89673b3ee89"}],"uri":"origin/pgc-image/3bb912eca5e743c98723f89673b3ee89","height":345,"content":"《西游记》以丰富瑰奇的想象描写了师徒四众在迢遥的西方途上和穷山恶水冒险斗争的历程，并将所经历的千难万险形象化为妖魔鬼怪所设置的八十一难，以动物幻化的有情的精怪生动地表现了无情的山川的险阻，并以降妖服怪歌赞了取经人排除艰难的战斗精神，小说是人战胜自然的凯歌。"},{"url":"http://p1.pstatp.com/origin/pgc-image/5df51aa417c84648888bcef3ac46e06a","width":363,"url_list":[{"url":"http://p1.pstatp.com/origin/pgc-image/5df51aa417c84648888bcef3ac46e06a"},{"url":"http://pb3.pstatp.com/origin/pgc-image/5df51aa417c84648888bcef3ac46e06a"},{"url":"http://pb9.pstatp.com/origin/pgc-image/5df51aa417c84648888bcef3ac46e06a"}],"uri":"origin/pgc-image/5df51aa417c84648888bcef3ac46e06a","height":384,"content":"唐僧：俗家姓陈，乳名江流，法名 玄奘，唐朝第一高僧，所以被人们称为唐僧。西行取经时，唐朝太宗皇帝李世民赐法名三藏。唐僧十八岁出家皈依佛门，经常青灯夜读，对佛家经典研修不断，而且悟性极高，二十来岁便名冠中国佛教，倍受唐朝太宗皇帝厚爱。后来被如来佛祖暗中选中去西天取经，并赐宝物三件，即袈裟、九环锡杖、金箍咒。唐僧身材高大，举止文雅、性情和善，佛经造诣极高。"},{"url":"http://p3.pstatp.com/origin/pgc-image/7f12cdae642240b9aa5a056c48f28f4e","width":363,"url_list":[{"url":"http://p3.pstatp.com/origin/pgc-image/7f12cdae642240b9aa5a056c48f28f4e"},{"url":"http://pb9.pstatp.com/origin/pgc-image/7f12cdae642240b9aa5a056c48f28f4e"},{"url":"http://pb1.pstatp.com/origin/pgc-image/7f12cdae642240b9aa5a056c48f28f4e"}],"uri":"origin/pgc-image/7f12cdae642240b9aa5a056c48f28f4e","height":384,"content":"孙悟空：法号行者，是唐僧的大徒弟，会七十二变、腾云驾雾。他占花果山为王，自称齐天大圣，搅乱王母娘娘的蟠桃胜会，偷吃太上老君的长生不老金丹，打败天宫十万天兵天将，又自不量力地与如来佛祖斗法，被压在五行山下五百多年。后来经观世音菩萨点化，保护唐僧西天取经，三打白骨精，收服红孩儿，熄灭火焰山，一路上降魔斗妖，历经九九八十一难，取回真经终成正果。他嫉恶如仇，坚韧不拔，英勇无畏，取经后被封为斗战胜佛。"},{"url":"http://p3.pstatp.com/origin/pgc-image/88f0a1b8bfb44d7b9cc1384fb04cc6b9","width":363,"url_list":[{"url":"http://p3.pstatp.com/origin/pgc-image/88f0a1b8bfb44d7b9cc1384fb04cc6b9"},{"url":"http://pb9.pstatp.com/origin/pgc-image/88f0a1b8bfb44d7b9cc1384fb04cc6b9"},{"url":"http://pb1.pstatp.com/origin/pgc-image/88f0a1b8bfb44d7b9cc1384fb04cc6b9"}],"uri":"origin/pgc-image/88f0a1b8bfb44d7b9cc1384fb04cc6b9","height":384,"content":" 猪八戒：法号悟能，是唐僧的二徒弟，原来是玉皇大帝的天蓬元帅，因调戏嫦娥被逐出天界，到人间投胎，却又错投猪胎，嘴脸与猪相似。唐僧西去取经路过云栈洞，猪八戒被孙悟空收服，八戒从此成为孙悟空的好帮手，一同保护唐僧西天取经。八戒性格温和，憨厚单纯，力气大，但又好吃懒做，爱占小便宜，贪图女色，难分敌我。他对师兄的话言听计从，对师父忠心耿耿，为唐僧西天取经立下汗马功劳，是个被人们喜爱同情的喜剧人物。"},{"url":"http://p3.pstatp.com/origin/pgc-image/b70f1d306c4c462b95bef6fc9489657b","width":363,"url_list":[{"url":"http://p3.pstatp.com/origin/pgc-image/b70f1d306c4c462b95bef6fc9489657b"},{"url":"http://pb9.pstatp.com/origin/pgc-image/b70f1d306c4c462b95bef6fc9489657b"},{"url":"http://pb1.pstatp.com/origin/pgc-image/b70f1d306c4c462b95bef6fc9489657b"}],"uri":"origin/pgc-image/b70f1d306c4c462b95bef6fc9489657b","height":384,"content":"沙和尚：法名悟净，原是天宫玉帝的卷帘大将，因触犯天条，被贬出天界，在人间流沙河兴风作浪。经南海观世音菩萨点化，拜唐僧为师，与孙悟空、猪八戒一起保护唐僧西天取经。他身上有两件宝，一件是菩萨葫芦，一件是九个骷髅组成的项圈。后来，他用九个骷髅作为九宫，把菩萨葫芦安放在其中，成为法船，稳似轻舟，顺利地帮助师徒四人渡河西去。沙和尚保护唐僧西天取经路上，任劳任怨，忠心不二，取经后被封为金身罗汉。"},{"url":"http://p1.pstatp.com/origin/pgc-image/2b6e9e02dba74a79a3e5a26048a16d32","width":363,"url_list":[{"url":"http://p1.pstatp.com/origin/pgc-image/2b6e9e02dba74a79a3e5a26048a16d32"},{"url":"http://pb3.pstatp.com/origin/pgc-image/2b6e9e02dba74a79a3e5a26048a16d32"},{"url":"http://pb9.pstatp.com/origin/pgc-image/2b6e9e02dba74a79a3e5a26048a16d32"}],"uri":"origin/pgc-image/2b6e9e02dba74a79a3e5a26048a16d32","height":384,"content":"白龙马：小白龙原来是西海龙王敖闰殿下的三太子。龙王三太子纵火烧了殿上玉帝赐的明珠，触犯天条，犯下死罪，幸亏大慈大悲的南海观世音菩萨出面，才幸免于难，被贬到蛇盘山等待唐僧西天取经。无奈他不识唐僧和悟空，误食唐僧坐骑白马，后来被观世音菩萨点化，锯角退鳞，变化成白龙马，皈依佛门，取经路上供唐僧坐骑，任劳任怨，历尽艰辛，终于修成正果，取经归来，被如来佛祖升为八部天龙。"},{"url":"http://p1.pstatp.com/origin/pgc-image/b7008e7916e746029a39b95e3daee661","width":363,"url_list":[{"url":"http://p1.pstatp.com/origin/pgc-image/b7008e7916e746029a39b95e3daee661"},{"url":"http://pb3.pstatp.com/origin/pgc-image/b7008e7916e746029a39b95e3daee661"},{"url":"http://pb9.pstatp.com/origin/pgc-image/b7008e7916e746029a39b95e3daee661"}],"uri":"origin/pgc-image/b7008e7916e746029a39b95e3daee661","height":384,"content":"观世音菩萨：经常手持净瓶杨柳，具有起死回生的神奇法力，也是如来佛祖得意的徒弟之一。他大慈大悲，普救人间灾难。唐僧师徒西天取经路上，孙悟空毁伤镇元大仙的人参果树无法医活，只好请观世音菩萨帮忙。只见观音菩左手持净瓶，右手持杨柳枝，稍蘸甘露，就使人参果树死而回生。他在唐僧取经路，帮助孙悟空收服红孩儿、天蓬元帅、西海龙王三太子等等，才使唐僧师徒到西天取得真经。"},{"url":"http://p1.pstatp.com/origin/pgc-image/c15d34f103fe4aae8e958248af5a85a9","width":363,"url_list":[{"url":"http://p1.pstatp.com/origin/pgc-image/c15d34f103fe4aae8e958248af5a85a9"},{"url":"http://pb3.pstatp.com/origin/pgc-image/c15d34f103fe4aae8e958248af5a85a9"},{"url":"http://pb9.pstatp.com/origin/pgc-image/c15d34f103fe4aae8e958248af5a85a9"}],"uri":"origin/pgc-image/c15d34f103fe4aae8e958248af5a85a9","height":384,"content":"菩提祖师：住在灵山方寸山斜月三星洞，是传授美猴王孙悟空武艺的师傅，对三教九流，长生之术，七十二变、腾云驾雾等样样精通。美猴王刚投到菩提祖师门下，祖师见他天性聪悟，给他取名悟空。随后教给孙悟空长生的法术，又教了七十二般变化的本领，再传授给十万八千里的筋斗云。十年功夫的悉心教授，使美猴王从顽劣的凡骨俗胎成为得道的神猴，身上八万四千根毫毛，根根能随心变化，为悟空闹天宫、保唐僧奠定了深厚的武功基础。"},{"url":"http://p3.pstatp.com/origin/pgc-image/c3898aecd0ad461cbab7408d1ff57c26","width":363,"url_list":[{"url":"http://p3.pstatp.com/origin/pgc-image/c3898aecd0ad461cbab7408d1ff57c26"},{"url":"http://pb9.pstatp.com/origin/pgc-image/c3898aecd0ad461cbab7408d1ff57c26"},{"url":"http://pb1.pstatp.com/origin/pgc-image/c3898aecd0ad461cbab7408d1ff57c26"}],"uri":"origin/pgc-image/c3898aecd0ad461cbab7408d1ff57c26","height":384,"content":"玉皇大帝：自幼修行，经历了三千多年才成金仙，又经过一千五百五十五劫，每劫为十二万九千六百年，才享受到无极大道，成为掌管天、地、人三界的最高主宰，玉帝住在金阙云宫灵霄宝殿，手下十代冥王管人间生死；四海龙王管天气变化；九曜星、五方将、二十八宿、四大天王等等神勇盖地；太白金星、二郎真君、五方五老各路神仙，个个法力无边；而且有西天如来佛祖暗中保护。玉帝大慈大悲，也是普救众生的大救星。"},{"url":"http://p1.pstatp.com/origin/pgc-image/f004fa5b8a4747bb84fe8a0cbba662d5","width":363,"url_list":[{"url":"http://p1.pstatp.com/origin/pgc-image/f004fa5b8a4747bb84fe8a0cbba662d5"},{"url":"http://pb3.pstatp.com/origin/pgc-image/f004fa5b8a4747bb84fe8a0cbba662d5"},{"url":"http://pb9.pstatp.com/origin/pgc-image/f004fa5b8a4747bb84fe8a0cbba662d5"}],"uri":"origin/pgc-image/f004fa5b8a4747bb84fe8a0cbba662d5","height":384,"content":"王母娘娘：住在瑶池，所以又叫瑶池娘娘。她在瑶池中开蟠桃胜会，宴请各路神仙，不料被齐天大圣孙悟空搅乱了蟠桃胜会。她种的蟠桃最为神奇，小桃树三千年一熟，人吃了体健身轻，成仙得道；一般的桃树六千年一熟，人吃了白日飞升，长生不老；最好的九千年一熟，人吃了与天地同寿，与日月同寿。她是天宫最受尊奉的女神仙，在天上掌管宴请各路神仙之职，在人间管婚姻和生儿育女之事。"},{"url":"http://p1.pstatp.com/origin/pgc-image/2a0eef40f7494fca92d24519a3dbfe35","width":363,"url_list":[{"url":"http://p1.pstatp.com/origin/pgc-image/2a0eef40f7494fca92d24519a3dbfe35"},{"url":"http://pb3.pstatp.com/origin/pgc-image/2a0eef40f7494fca92d24519a3dbfe35"},{"url":"http://pb9.pstatp.com/origin/pgc-image/2a0eef40f7494fca92d24519a3dbfe35"}],"uri":"origin/pgc-image/2a0eef40f7494fca92d24519a3dbfe35","height":384,"content":"太上老君：姓李名耳，道教创始人，因而称为太上老君。他住在兜率宫练金丹，常骑青牛。他有个法宝叫金钢琢，非常厉害，在捉拿大闹天宫的孙悟空时立下功劳，却又被他的青牛偷去，在金洞多次斗败孙悟空、托塔天王、十八罗汉等神仙，最后老君宝扇一扇，收走了金钢琢，降服了青牛精。他是一个息事宁人，轻易不与人争斗的老好人。"},{"url":"http://p1.pstatp.com/origin/pgc-image/81835ab538374d70970a0bb15138bd25","width":363,"url_list":[{"url":"http://p1.pstatp.com/origin/pgc-image/81835ab538374d70970a0bb15138bd25"},{"url":"http://pb3.pstatp.com/origin/pgc-image/81835ab538374d70970a0bb15138bd25"},{"url":"http://pb9.pstatp.com/origin/pgc-image/81835ab538374d70970a0bb15138bd25"}],"uri":"origin/pgc-image/81835ab538374d70970a0bb15138bd25","height":384,"content":"灵吉菩萨：住在小须弥山，法力广大，手使飞龙宝杖，并有如来赐给的定风珠等宝贝。唐僧取经在黄风岭被黄毛貂鼠精捉住，孙悟空驾筋斗云请来灵吉菩萨。灵吉将飞龙宝杖抛起，变成八爪金龙，张开双爪，捉住妖精，使妖精现出了黄毛貂鼠的本相。后来，唐僧被阻挡在八百里火焰山，铁扇公主用芭蕉神扇把孙悟空扇得如败叶残花，又是灵吉菩萨把定风珠借给悟空，才抵抗了罗刹女的芭蕉扇。"},{"url":"http://p3.pstatp.com/origin/pgc-image/e56bd556d1c1441ba8bb67aeed74ef1c","width":363,"url_list":[{"url":"http://p3.pstatp.com/origin/pgc-image/e56bd556d1c1441ba8bb67aeed74ef1c"},{"url":"http://pb9.pstatp.com/origin/pgc-image/e56bd556d1c1441ba8bb67aeed74ef1c"},{"url":"http://pb1.pstatp.com/origin/pgc-image/e56bd556d1c1441ba8bb67aeed74ef1c"}],"uri":"origin/pgc-image/e56bd556d1c1441ba8bb67aeed74ef1c","height":384,"content":"南极寿星：头上有个大肉包，手拄蟠龙拐杖，白鹿紧随身后，供他骑乘。不料这白鹿凡心不灭，趁南极寿星与东华帝君下棋的机会，借着数千年修炼的道行，下到凡间的比丘国，与狐狸精狼狈为奸，专用小孩心肝作长寿药引，祸害百姓，结果遇到火眼金睛的孙悟空，难逃劫难，被悟空降服。悟空正要打杀白鹿精时，南极仙翁赶到，命令妖怪现出原形，驼南极寿星回归仙山。"},{"url":"http://p1.pstatp.com/origin/pgc-image/361e23012e634384bba6ba9bf6152957","width":363,"url_list":[{"url":"http://p1.pstatp.com/origin/pgc-image/361e23012e634384bba6ba9bf6152957"},{"url":"http://pb3.pstatp.com/origin/pgc-image/361e23012e634384bba6ba9bf6152957"},{"url":"http://pb9.pstatp.com/origin/pgc-image/361e23012e634384bba6ba9bf6152957"}],"uri":"origin/pgc-image/361e23012e634384bba6ba9bf6152957","height":384,"content":"太白金星：是天界一位颇有名气的星宿，法力广大，又比较和善。孙悟空闯地府、闹龙宫，玉皇大帝正要发兵征讨，太白金星替悟空说情，建议封悟空为管理御马的弼马温。孙悟空二反天宫时，又是金星出面为招安使，封悟空为齐天大圣，管理蟠桃园。后来，在唐僧师徒西天取经的路上，长庚星多次暗中帮助师徒四人战胜黄风怪，扫荡狮驼洞，是个和善的好老头。"},{"url":"http://p1.pstatp.com/origin/pgc-image/6b8ae845f05d40e0a254ff306063d074","width":363,"url_list":[{"url":"http://p1.pstatp.com/origin/pgc-image/6b8ae845f05d40e0a254ff306063d074"},{"url":"http://pb3.pstatp.com/origin/pgc-image/6b8ae845f05d40e0a254ff306063d074"},{"url":"http://pb9.pstatp.com/origin/pgc-image/6b8ae845f05d40e0a254ff306063d074"}],"uri":"origin/pgc-image/6b8ae845f05d40e0a254ff306063d074","height":384,"content":"镇元大仙：是地仙之祖，道号镇元子，住在西牛贺洲的五庄观上，道术深厚精深，连观世音菩萨也让他三分。他种的人参果，九千年成熟一次，吃一颗，就能活四万七千年。在与孙悟空打斗中，只两三个回合，他施展袖里乾坤的法术，把唐僧师徒连人带马装进袖子里，本领着实厉害。当孙悟空请来菩萨救活人参果树后，他不记前嫌，与孙悟空结拜为兄弟，用珍贵的人参果宴众仙和唐僧师徒，颇有大仙气度。"},{"url":"http://p9.pstatp.com/origin/pgc-image/e7eb00c1ae854ed8a7713717e57a1c11","width":363,"url_list":[{"url":"http://p9.pstatp.com/origin/pgc-image/e7eb00c1ae854ed8a7713717e57a1c11"},{"url":"http://pb1.pstatp.com/origin/pgc-image/e7eb00c1ae854ed8a7713717e57a1c11"},{"url":"http://pb3.pstatp.com/origin/pgc-image/e7eb00c1ae854ed8a7713717e57a1c11"}],"uri":"origin/pgc-image/e7eb00c1ae854ed8a7713717e57a1c11","height":384,"content":"东来佛祖：又称作弥勒佛，大耳方面，腹满体胖，笑容常在，又被人们俗称笑和尚。佛曾预言，弥勒菩萨经历五十六亿七千万年出生于第十道灭劫，继承释迦牟尼佛的佛位，在华林园龙华树下成佛，所以又称未来佛。他殿下敲磬的黄眉童儿，偷走了后天袋子，把孙悟空等神仙斗得没有办法。最后多亏东来佛祖相助，帮孙悟空降服黄眉童儿。"},{"url":"http://p1.pstatp.com/origin/pgc-image/094855e82dad470b890937484aa5b211","width":363,"url_list":[{"url":"http://p1.pstatp.com/origin/pgc-image/094855e82dad470b890937484aa5b211"},{"url":"http://pb3.pstatp.com/origin/pgc-image/094855e82dad470b890937484aa5b211"},{"url":"http://pb9.pstatp.com/origin/pgc-image/094855e82dad470b890937484aa5b211"}],"uri":"origin/pgc-image/094855e82dad470b890937484aa5b211","height":384,"content":"二郎真君：姓杨名戬，是玉皇大帝的外甥，常住灌江口，使用的兵器是三尖两刃枪，具有七十三般变化，善于腾云驾雾，还有一只神勇的哮天犬，手下的梅山六兄弟也非常了得。在与大闹天宫的孙悟空大战中，他武打文斗，终于把武艺非凡的孙悟空捉住。他在天宫中武艺超群，因此十分显赫的地位。唐僧西天取经路上，二郎神又帮助孙悟空打败了九头怪，消除了唐僧一难。"},{"url":"http://p1.pstatp.com/origin/pgc-image/1cc595c9ca194ce1b66506b05cb83c0f","width":363,"url_list":[{"url":"http://p1.pstatp.com/origin/pgc-image/1cc595c9ca194ce1b66506b05cb83c0f"},{"url":"http://pb3.pstatp.com/origin/pgc-image/1cc595c9ca194ce1b66506b05cb83c0f"},{"url":"http://pb9.pstatp.com/origin/pgc-image/1cc595c9ca194ce1b66506b05cb83c0f"}],"uri":"origin/pgc-image/1cc595c9ca194ce1b66506b05cb83c0f","height":384,"content":"托塔天王：姓李名靖，早年因与三子哪吒反目，如来佛祖赐他一座舍利子如意黄金宝塔，化解了父子前仇，所以称为托塔李天王。李家父子武艺超群，法力深厚，又对玉帝忠心耿耿，在天界享有崇高而又重要的地位。两次平息孙猴子造反，都是任命他为降魔大元帅，手下的巨灵神、鱼肚将、哪吒三太子等十万神将天兵，均是天王所统率的精兵良将，在取经途中帮了唐僧四人度过不少劫难。"},{"url":"http://p3.pstatp.com/origin/pgc-image/08a1a6b871c942f487d78c60a6103e12","width":363,"url_list":[{"url":"http://p3.pstatp.com/origin/pgc-image/08a1a6b871c942f487d78c60a6103e12"},{"url":"http://pb9.pstatp.com/origin/pgc-image/08a1a6b871c942f487d78c60a6103e12"},{"url":"http://pb1.pstatp.com/origin/pgc-image/08a1a6b871c942f487d78c60a6103e12"}],"uri":"origin/pgc-image/08a1a6b871c942f487d78c60a6103e12","height":384,"content":"如来佛祖：法力无边，手下的八大金刚、十八罗汉、各路菩萨，个个都有千般变化。英勇无比的孙悟空，一个筋斗云十万八千里，但却翻不出如来佛的手掌心。如来的本意是乘真如来之道而来，也就是说如实而来，是佛教的祖师。他的种族名释迦，牟尼是圣人的意思，合起来叫释迦圣人，他原是古印度北部一个王子，因为对当时的婆罗门教不满，出家修行，创立佛教。"},{"url":"http://p3.pstatp.com/origin/pgc-image/d60f6ead09b44855a11a7403ed2d0a3a","width":363,"url_list":[{"url":"http://p3.pstatp.com/origin/pgc-image/d60f6ead09b44855a11a7403ed2d0a3a"},{"url":"http://pb9.pstatp.com/origin/pgc-image/d60f6ead09b44855a11a7403ed2d0a3a"},{"url":"http://pb1.pstatp.com/origin/pgc-image/d60f6ead09b44855a11a7403ed2d0a3a"}],"uri":"origin/pgc-image/d60f6ead09b44855a11a7403ed2d0a3a","height":384,"content":"文殊菩萨：住在五台山，在佛界名气很大，他骑著一头青毛狮子。不料这青狮趁狮奴打盹儿时，下凡到人间，在狮驼岭兴妖作怪，擒住唐僧，也想吃圣僧以求长生不老，连悟空也难以战胜。后来，如来佛祖命令文殊菩萨收取狮怪。当孙悟空引诱狮怪出洞大战时，文殊菩萨抛起莲花台，正好落在妖怪的脊背上，降服了青毛狮子怪。"},{"url":"http://p1.pstatp.com/origin/pgc-image/04dd9fefadf14f55ad0165ecf37b82ea","width":363,"url_list":[{"url":"http://p1.pstatp.com/origin/pgc-image/04dd9fefadf14f55ad0165ecf37b82ea"},{"url":"http://pb3.pstatp.com/origin/pgc-image/04dd9fefadf14f55ad0165ecf37b82ea"},{"url":"http://pb9.pstatp.com/origin/pgc-image/04dd9fefadf14f55ad0165ecf37b82ea"}],"uri":"origin/pgc-image/04dd9fefadf14f55ad0165ecf37b82ea","height":384,"content":"普贤菩萨：住在峨眉山，在佛界享有很高的地位，坐骑是一头白象。这白象不安于天界寂寞，趁象奴疏忽之机，思凡下界，在狮驼岭一带与青毛狮子怪、万里鹏怪一起兴风作浪，想吃唐僧肉求得长生不老。无奈天网恢恢，疏而不漏，如来佛祖命令普贤菩萨下界收妖。等孙悟空诱使黄牙象怪出了山洞，普贤菩萨把莲花台丢在象怪背上，使其现出原形，随菩萨回山。"},{"url":"http://p3.pstatp.com/origin/pgc-image/f34555aa65da4d3890d9d7abe1f78a29","width":363,"url_list":[{"url":"http://p3.pstatp.com/origin/pgc-image/f34555aa65da4d3890d9d7abe1f78a29"},{"url":"http://pb9.pstatp.com/origin/pgc-image/f34555aa65da4d3890d9d7abe1f78a29"},{"url":"http://pb1.pstatp.com/origin/pgc-image/f34555aa65da4d3890d9d7abe1f78a29"}],"uri":"origin/pgc-image/f34555aa65da4d3890d9d7abe1f78a29","height":384,"content":"四海龙王：是奉玉帝之命管理海洋的四个神仙，弟兄四个中东海龙王敖广为大，其次是南海龙王敖钦、北海龙王敖顺、西海龙王敖闰。四海龙王的职责是管理海洋中的生灵，在人间司风管雨，统帅无数虾兵蟹将。唐僧西天取经，四海龙王曾多次帮忙，或去兴风作雨，或率兵助阵，自己的外甥小鼍龙触犯了圣僧，他们也不徇私情，逮捕归案。"},{"url":"http://p9.pstatp.com/origin/pgc-image/2f24694e1d36480aba49580afab4201b","width":363,"url_list":[{"url":"http://p9.pstatp.com/origin/pgc-image/2f24694e1d36480aba49580afab4201b"},{"url":"http://pb1.pstatp.com/origin/pgc-image/2f24694e1d36480aba49580afab4201b"},{"url":"http://pb3.pstatp.com/origin/pgc-image/2f24694e1d36480aba49580afab4201b"}],"uri":"origin/pgc-image/2f24694e1d36480aba49580afab4201b","height":384,"content":"阴曹阎王：是阴间天子十殿冥王之一，手下有五官，鲜官禁杀，水官禁盗，铁官禁淫，土官禁两舌，天官禁酒。他在天界掌管人间生老病死，手下的黑无常、白无常、催命判官，全做的是勾命的事情。遇到蛮横的孙悟空举起如意金箍棒，阎罗天子也连连讨饶，在生死簿上消去了悟空的姓名。碰到人间的唐朝皇帝李世民，又索要银两礼品，得到满足后就给延寿二十年。看来，这个阎罗天子也是个欺软怕硬、贪财好物的角色。"},{"url":"http://p3.pstatp.com/origin/pgc-image/5dc1441c8f8f4e9497864ff2e8bc8c0b","width":363,"url_list":[{"url":"http://p3.pstatp.com/origin/pgc-image/5dc1441c8f8f4e9497864ff2e8bc8c0b"},{"url":"http://pb9.pstatp.com/origin/pgc-image/5dc1441c8f8f4e9497864ff2e8bc8c0b"},{"url":"http://pb1.pstatp.com/origin/pgc-image/5dc1441c8f8f4e9497864ff2e8bc8c0b"}],"uri":"origin/pgc-image/5dc1441c8f8f4e9497864ff2e8bc8c0b","height":384,"content":"昴日星官：是天界光明宫的神仙，专职司晨的大公鸡，其母是大慈大悲的毗蓝婆菩萨。唐僧师徒西天取经，途中在毒敌山琵琶洞被蝎子精困住，那妖怪异想天开，想与唐僧结为夫妻，好取圣僧的真阳之气。孙悟空、猪八戒久战难以取胜，多亏观音菩萨指点，昴日星官慷慨答应下界捉妖。等到孙悟空引诱蝎子精出洞来战，星官现出本相，变成六七尺高的大公鸡，长叫一声，妖怪现出原形，再叫一声，蝎子精浑身酥软，死于面前。"},{"url":"http://p3.pstatp.com/origin/pgc-image/9ed893d52a2f4a638b2306da95ea2d14","width":363,"url_list":[{"url":"http://p3.pstatp.com/origin/pgc-image/9ed893d52a2f4a638b2306da95ea2d14"},{"url":"http://pb9.pstatp.com/origin/pgc-image/9ed893d52a2f4a638b2306da95ea2d14"},{"url":"http://pb1.pstatp.com/origin/pgc-image/9ed893d52a2f4a638b2306da95ea2d14"}],"uri":"origin/pgc-image/9ed893d52a2f4a638b2306da95ea2d14","height":384,"content":"哪吒三太子：是托塔李天王的第三个儿子，也是如来佛祖的弟子之一。他三岁就下海，闯下大祸，踏倒水晶宫，捉住蛟龙抽筋刮鳞。哪吒年少但法力广大，可以变化为三头六臂，足蹬风火轮，手使一柄金枪，项戴乾坤圈，又有斩妖剑、砍妖刀、缚妖索、降妖杵、绣球儿等六件法宝，变化多端。每逢托塔天王挂帅出征，哪吒必然前往，有时当先锋，有时为大将，先后降服九十六个妖魔，是天上人间公认的少年小英雄。"},{"url":"http://p3.pstatp.com/origin/pgc-image/9050315289f64a3e8ae1904b9f139c08","width":363,"url_list":[{"url":"http://p3.pstatp.com/origin/pgc-image/9050315289f64a3e8ae1904b9f139c08"},{"url":"http://pb9.pstatp.com/origin/pgc-image/9050315289f64a3e8ae1904b9f139c08"},{"url":"http://pb1.pstatp.com/origin/pgc-image/9050315289f64a3e8ae1904b9f139c08"}],"uri":"origin/pgc-image/9050315289f64a3e8ae1904b9f139c08","height":384,"content":"摩昂太子：是西海龙王敖闰的太子，为人忠勇，不徇私情，手执一柄三棱锏，武艺十分了得。敖摩昂的姑表弟小鼍龙，在黑水河捉住唐僧，邀请舅舅西海龙王来吃唐僧肉，西海龙王得知后，立即派摩昂率兵捉拿鼍龙，表兄弟在黑水河混战一场，小鼍龙怎敌得住表兄摩昂的高超武艺。三五个回合摩昂就将鼍龙擒住归案，解救唐僧和八戒。后来，在孙悟空与四禽木星追赶玄英洞三个妖魔时，摩昂太子又率兵助阵，帮助悟空捉住三个犀牛精，又立了一大功。"},{"url":"http://p1.pstatp.com/origin/pgc-image/f4a42ed82eb04ff5ac0461ea2dee228d","width":363,"url_list":[{"url":"http://p1.pstatp.com/origin/pgc-image/f4a42ed82eb04ff5ac0461ea2dee228d"},{"url":"http://pb3.pstatp.com/origin/pgc-image/f4a42ed82eb04ff5ac0461ea2dee228d"},{"url":"http://pb9.pstatp.com/origin/pgc-image/f4a42ed82eb04ff5ac0461ea2dee228d"}],"uri":"origin/pgc-image/f4a42ed82eb04ff5ac0461ea2dee228d","height":384,"content":"嫦娥：原是天神后羿的妻子。天神后羿射落九个太阳，得罪天帝被贬下凡。夫妻二人不能回到天上，后羿便去求取长生不老药。西王母赐后羿灵药，此药两人分吃可以长生不死，一人独吃可以升天成仙。嫦娥飞到冷清无人的月宫，只有一只玉兔和一棵桂树陪伴她。天河里的天蓬元帅由于酒醉调戏嫦娥，被贬下界错投猪胎成为后来的猪八戒。嫦娥的玉兔因报私仇下凡成妖作怪，后被太阴星君降伏收回月宫，除去唐僧师徒西天取经路上一难。"},{"url":"http://p1.pstatp.com/origin/pgc-image/48ffd3d5e1934806b6cacdd521d397a5","width":363,"url_list":[{"url":"http://p1.pstatp.com/origin/pgc-image/48ffd3d5e1934806b6cacdd521d397a5"},{"url":"http://pb3.pstatp.com/origin/pgc-image/48ffd3d5e1934806b6cacdd521d397a5"},{"url":"http://pb9.pstatp.com/origin/pgc-image/48ffd3d5e1934806b6cacdd521d397a5"}],"uri":"origin/pgc-image/48ffd3d5e1934806b6cacdd521d397a5","height":384,"content":" 毗蓝婆菩萨：住在紫云山千花洞，是昴日星官的母亲，法力无边，大慈大悲。唐僧被百眼魔君捉住，十分危险，悟空又难以战胜妖精，幸亏黎山老母指点，悟空请求毗蓝婆菩萨帮助。毗蓝婆菩萨用儿子昴日星官炼成的宝贝，抛向天空，就破了百眼妖魔的妖术。毗蓝用手一指，妖魔现出原身，悟空一把火把妖精住的黄花观烧了个精光。"},{"url":"http://p1.pstatp.com/origin/pgc-image/2341ea9dec17485696bee72125fdd146","width":363,"url_list":[{"url":"http://p1.pstatp.com/origin/pgc-image/2341ea9dec17485696bee72125fdd146"},{"url":"http://pb3.pstatp.com/origin/pgc-image/2341ea9dec17485696bee72125fdd146"},{"url":"http://pb9.pstatp.com/origin/pgc-image/2341ea9dec17485696bee72125fdd146"}],"uri":"origin/pgc-image/2341ea9dec17485696bee72125fdd146","height":384,"content":"巨灵神：是托塔天王帐下的一员战将，使用的兵器是件宣花板斧，舞动起沉重的宣花板斧，就象凤凰穿花，灵巧无比。在托塔天王率十万天兵天将征讨造反的孙猴子时，巨灵神为先锋大将，可见其武艺与法力不同一般。"},{"url":"http://p1.pstatp.com/origin/pgc-image/a5ff259590ab4b1a81f831871f81f552","width":363,"url_list":[{"url":"http://p1.pstatp.com/origin/pgc-image/a5ff259590ab4b1a81f831871f81f552"},{"url":"http://pb3.pstatp.com/origin/pgc-image/a5ff259590ab4b1a81f831871f81f552"},{"url":"http://pb9.pstatp.com/origin/pgc-image/a5ff259590ab4b1a81f831871f81f552"}],"uri":"origin/pgc-image/a5ff259590ab4b1a81f831871f81f552","height":384,"content":"木叉：又叫木吒，是托塔天王的二儿子，哪吒的二兄长，法名惠岸，是南海观世音菩萨的护教大徒弟。木叉使用的兵器是一柄浑铁棍，神勇非凡，而且会多端变化。他常随观音菩萨出游，又暗中帮助唐僧师徒战胜妖魔，为唐僧西行取经立下功劳。"},{"url":"http://p1.pstatp.com/origin/pgc-image/f0afc345eed64cd0b019aae391ade8ba","width":363,"url_list":[{"url":"http://p1.pstatp.com/origin/pgc-image/f0afc345eed64cd0b019aae391ade8ba"},{"url":"http://pb3.pstatp.com/origin/pgc-image/f0afc345eed64cd0b019aae391ade8ba"},{"url":"http://pb9.pstatp.com/origin/pgc-image/f0afc345eed64cd0b019aae391ade8ba"}],"uri":"origin/pgc-image/f0afc345eed64cd0b019aae391ade8ba","height":384,"content":"熊罴怪：原是一头黑熊，住在黑风山里的黑风洞，修行多年成为精怪，使一柄黑缨长枪，善于变化，手段也很厉害。唐僧取经路上，这个黑熊精偷走如来佛祖赐给唐僧的宝贝袈裟。孙悟空与他争斗多次，也未讨回师傅的袈裟，只好求救于南海观音菩萨。观音假装送给熊精一粒仙丹，使黑熊精现出原形，为唐僧讨回袈裟。后来，黑熊怪皈依佛门，摩顶受戒，在菩萨的落伽山后当了守山大神。"},{"url":"http://p1.pstatp.com/origin/pgc-image/482633f8000949eb91d9758d6b2f25ed","width":363,"url_list":[{"url":"http://p1.pstatp.com/origin/pgc-image/482633f8000949eb91d9758d6b2f25ed"},{"url":"http://pb3.pstatp.com/origin/pgc-image/482633f8000949eb91d9758d6b2f25ed"},{"url":"http://pb9.pstatp.com/origin/pgc-image/482633f8000949eb91d9758d6b2f25ed"}],"uri":"origin/pgc-image/482633f8000949eb91d9758d6b2f25ed","height":384,"content":"黄风大圣：又叫黄风怪，原是灵山脚下得道的老鼠，因为偷吃琉璃盏内的清油，怕金刚捉拿问罪，跑到黄风岭兴妖作怪。黄风怪使用一杆三股钢叉，十分骁勇，与孙悟空在黄风岭上打斗三十多个回合，未见胜负。黄风怪吹起狂风，刮得悟空象纺车一样在空中乱转，火眼金睛酸痛。无奈之际，悟空从小须弥上搬来了灵吉菩萨，用定风珠和飞龙才降服黄风怪，使之现出黄毛貂鼠的本相，救出了唐僧。"},{"url":"http://p1.pstatp.com/origin/pgc-image/9e568a84e08247719c5aee4913a6a188","width":363,"url_list":[{"url":"http://p1.pstatp.com/origin/pgc-image/9e568a84e08247719c5aee4913a6a188"},{"url":"http://pb3.pstatp.com/origin/pgc-image/9e568a84e08247719c5aee4913a6a188"},{"url":"http://pb9.pstatp.com/origin/pgc-image/9e568a84e08247719c5aee4913a6a188"}],"uri":"origin/pgc-image/9e568a84e08247719c5aee4913a6a188","height":384,"content":"南山大王：本是只艾叶花皮豹子精，修行数百年成妖，在隐雾山折岳连环洞作怪，使一根铁杵，勇猛异常。他使用分瓣梅花计，捉住唐僧。孙悟空救师心切，一会儿变成水老鼠，一会儿变成会飞的蚂蚁，用瞌睡虫放倒看守唐僧的小妖怪，和八戒打入妖精洞府，打死妖精，救出师父。"},{"url":"http://p3.pstatp.com/origin/pgc-image/6104433362d74aaf8963e2972ab436d8","width":363,"url_list":[{"url":"http://p3.pstatp.com/origin/pgc-image/6104433362d74aaf8963e2972ab436d8"},{"url":"http://pb9.pstatp.com/origin/pgc-image/6104433362d74aaf8963e2972ab436d8"},{"url":"http://pb1.pstatp.com/origin/pgc-image/6104433362d74aaf8963e2972ab436d8"}],"uri":"origin/pgc-image/6104433362d74aaf8963e2972ab436d8","height":384,"content":"黑水河鼍怪：原来是西海龙王敖闰的外甥鼍龙，手使一根竹节钢鞭，抢占了卫阳峪黑水河神的府第，又用计擒住唐僧和八戒，也想吃唐僧肉长生不老。孙悟空知道他的出身后，闯进西海龙宫，连唬带吓，逼迫西海龙王派太子敖摩昂率兵征讨收服鼍龙，解救了唐僧一难。"},{"url":"http://p1.pstatp.com/origin/pgc-image/5dc76ca17d2a4abd976640eb1571a934","width":363,"url_list":[{"url":"http://p1.pstatp.com/origin/pgc-image/5dc76ca17d2a4abd976640eb1571a934"},{"url":"http://pb3.pstatp.com/origin/pgc-image/5dc76ca17d2a4abd976640eb1571a934"},{"url":"http://pb9.pstatp.com/origin/pgc-image/5dc76ca17d2a4abd976640eb1571a934"}],"uri":"origin/pgc-image/5dc76ca17d2a4abd976640eb1571a934","height":384,"content":" 黄眉大王：原本是东来佛祖笑和尚敲磬的童子，手使一根由敲磬槌变成短软狼牙棒。此怪胆大妄为，假设雷音寺诱使唐僧师徒上当，并把悟空扣在金钹里。又施展人种袋，数次把孙悟空和天兵天将收入袋子。紧急关头，东来佛祖笑呵呵踏云而来，教悟空诱使妖怪出洞，弥勒佛变成种瓜叟，让妖魔把悟空变成的西瓜吃进肚子，治服了黄眉大王，弥勒佛也趁机收回了人种袋子等宝物。"},{"url":"http://p3.pstatp.com/origin/pgc-image/86a5ae82e16345aca9dbb60db4818765","width":363,"url_list":[{"url":"http://p3.pstatp.com/origin/pgc-image/86a5ae82e16345aca9dbb60db4818765"},{"url":"http://pb9.pstatp.com/origin/pgc-image/86a5ae82e16345aca9dbb60db4818765"},{"url":"http://pb1.pstatp.com/origin/pgc-image/86a5ae82e16345aca9dbb60db4818765"}],"uri":"origin/pgc-image/86a5ae82e16345aca9dbb60db4818765","height":384,"content":"六耳猕猴：神通广大，多端变化，腾云驾雾，样样精通，非常了得。这个妖精趁唐僧赶走孙悟空的机会，变成孙悟空，差点打死唐僧，抢去唐僧的衣钵，又嫁祸给孙悟空，霸占了花果山。悟空与他交战，难以取胜，打到天宫，众神仙难辨真假。真假悟空打到西天雷音寺之后，如来佛祖慧眼一睁，六耳猕猴恐难逃法网，急忙变成小蜜蜂慌张逃走，如来抛起金钵盂，扣住蜜蜂，现出六耳猕猴的原形，被悟空一棒打死。"},{"url":"http://p1.pstatp.com/origin/pgc-image/cedcca25bfe9490b9104afd0d8b75fce","width":363,"url_list":[{"url":"http://p1.pstatp.com/origin/pgc-image/cedcca25bfe9490b9104afd0d8b75fce"},{"url":"http://pb3.pstatp.com/origin/pgc-image/cedcca25bfe9490b9104afd0d8b75fce"},{"url":"http://pb9.pstatp.com/origin/pgc-image/cedcca25bfe9490b9104afd0d8b75fce"}],"uri":"origin/pgc-image/cedcca25bfe9490b9104afd0d8b75fce","height":384,"content":"通天河鱼怪：原来是普陀山莲池中的一尾金鱼，每日浮头听菩萨讲经，炼成一身的本事，偷偷离开菩萨下凡，在通天河两岸专吃童男童女。鱼怪使用的兵器是一柄九瓣铜锤。他使用降雪的法术，冻住通天河，当唐僧走到河中央，鱼怪打开冰冻，捉住唐僧。危难之际，观音菩萨下山，收服鱼怪，救出唐僧。"},{"url":"http://p3.pstatp.com/origin/pgc-image/c278208a80044979bbdde7b399eff689","width":363,"url_list":[{"url":"http://p3.pstatp.com/origin/pgc-image/c278208a80044979bbdde7b399eff689"},{"url":"http://pb9.pstatp.com/origin/pgc-image/c278208a80044979bbdde7b399eff689"},{"url":"http://pb1.pstatp.com/origin/pgc-image/c278208a80044979bbdde7b399eff689"}],"uri":"origin/pgc-image/c278208a80044979bbdde7b399eff689","height":384,"content":"红孩儿：号圣婴大王，住在号山枯松涧火云洞。是牛魔王的儿子，铁扇公主养的小妖怪，使用一杆八丈火尖枪，武功非凡，又在火焰山修练三百年，练成三昧真火，经常与人赤脚打斗。红孩儿听说吃唐僧肉可以长生不老，用狂风卷走唐僧，用计骗擒八戒。孙悟空战之不胜，去落伽山请来观音菩萨，又让护法惠岸木叉借来李天王的天罡刀，收服了红孩儿，让他做了观音菩萨的善财童子，最终成了正果。"},{"url":"http://p3.pstatp.com/origin/pgc-image/3e7766342433476ea849363cb9707c8b","width":363,"url_list":[{"url":"http://p3.pstatp.com/origin/pgc-image/3e7766342433476ea849363cb9707c8b"},{"url":"http://pb9.pstatp.com/origin/pgc-image/3e7766342433476ea849363cb9707c8b"},{"url":"http://pb1.pstatp.com/origin/pgc-image/3e7766342433476ea849363cb9707c8b"}],"uri":"origin/pgc-image/3e7766342433476ea849363cb9707c8b","height":384,"content":"独角兕大王：本是太上老君坐骑青牛，趁着牛童儿瞌睡之际，偷走老君的宝贝金钢琢，下界到金山金洞。独角兕大王仗着太上老君的宝物金钢琢，套住悟空的金箍棒，将他打败。悟空只好到天宫搬来救兵，最后皆败给了金刚琢。多亏如来佛祖暗示孙悟空，请来了太上老君，使妖怪现出青牛本相，老君跨上牛背，悟空等率众打入洞中，杀死小妖。"},{"url":"http://p1.pstatp.com/origin/pgc-image/07edefb89c3a4bc18e2c7a034c420af0","width":363,"url_list":[{"url":"http://p1.pstatp.com/origin/pgc-image/07edefb89c3a4bc18e2c7a034c420af0"},{"url":"http://pb3.pstatp.com/origin/pgc-image/07edefb89c3a4bc18e2c7a034c420af0"},{"url":"http://pb9.pstatp.com/origin/pgc-image/07edefb89c3a4bc18e2c7a034c420af0"}],"uri":"origin/pgc-image/07edefb89c3a4bc18e2c7a034c420af0","height":384,"content":"百眼魔君：又叫作多眼怪，住在黄花观，祸害百姓。多目怪长了一千只眼睛，只只眼睛金光四射，使人向前不能靠近，往后不得后退，就象罩在无形的光网之中。整得神通广大的孙悟空也是没有办法。幸亏骊山老母指点，孙悟空驾云到紫云山千花洞，请来了毗蓝婆菩萨，破了多目怪的金光罩，救出了唐僧、八戒和沙僧。经毗蓝婆菩萨施展法术，多目怪现出原形，原来是条七尺长的蜈蚣精。"},{"url":"http://p3.pstatp.com/origin/pgc-image/db69839706444f3a843efb5d8afbf978","width":363,"url_list":[{"url":"http://p3.pstatp.com/origin/pgc-image/db69839706444f3a843efb5d8afbf978"},{"url":"http://pb9.pstatp.com/origin/pgc-image/db69839706444f3a843efb5d8afbf978"},{"url":"http://pb1.pstatp.com/origin/pgc-image/db69839706444f3a843efb5d8afbf978"}],"uri":"origin/pgc-image/db69839706444f3a843efb5d8afbf978","height":384,"content":"白骨精：又叫白骨夫人，是唐僧西天取经途中遇见的少有的女妖精，使用双剑，武艺出色，想吃唐僧肉，先变成十六七岁的漂亮少女，再变成一个八十岁的老婆婆，后变成年迈力衰的老翁，使出离间计，使唐僧逼走孙悟空，把唐僧捉住。在唐僧险遭杀身之祸时，神通广大的孙悟空多番变化，几经争斗，终于打得白骨精露出原形，救出了唐僧。"},{"url":"http://p1.pstatp.com/origin/pgc-image/26e813dff1d14d4e9bbabcb75a0f3126","width":363,"url_list":[{"url":"http://p1.pstatp.com/origin/pgc-image/26e813dff1d14d4e9bbabcb75a0f3126"},{"url":"http://pb3.pstatp.com/origin/pgc-image/26e813dff1d14d4e9bbabcb75a0f3126"},{"url":"http://pb9.pstatp.com/origin/pgc-image/26e813dff1d14d4e9bbabcb75a0f3126"}],"uri":"origin/pgc-image/26e813dff1d14d4e9bbabcb75a0f3126","height":384,"content":" 金角大王和银角大王：是平顶山莲花洞的两个妖怪。菩萨为了试验唐僧西天取经的决心，向太上老君借来金、银角二童，变作妖怪磨砺唐僧取经的决心。金、银角二大王使用的兵器都是一把七星宝剑，并且有红葫芦、玉净瓶、芭蕉扇、金绳子几件宝物，与孙悟空比武斗法，难分输赢。后来孙悟空开动脑筋，用计谋战胜金、银二怪，收缴了五件宝物，连人带物返还给太上老君，战胜了西行路上一个灾难。　"},{"url":"http://p1.pstatp.com/origin/pgc-image/475dee8beb1d426f9b49ca2097e8e56d","width":363,"url_list":[{"url":"http://p1.pstatp.com/origin/pgc-image/475dee8beb1d426f9b49ca2097e8e56d"},{"url":"http://pb3.pstatp.com/origin/pgc-image/475dee8beb1d426f9b49ca2097e8e56d"},{"url":"http://pb9.pstatp.com/origin/pgc-image/475dee8beb1d426f9b49ca2097e8e56d"}],"uri":"origin/pgc-image/475dee8beb1d426f9b49ca2097e8e56d","height":384,"content":" 狮魔王：原来是文殊菩萨座下的青毛狮子，善于变化，武器是一把宝刀。经如来佛祖同意，派青毛狮子下凡，把以前捆绑过文殊菩萨的乌鸡国王推入八角琉璃井后，变化成国王模样取而代之，当了三年国王。唐僧师徒西行到乌鸡国，夜晚遇到乌鸡国国王灵魂诉说冤屈，孙悟空奉唐僧之命，上天向太上老君借来九转还魂丹，救活国王，在文殊菩萨的帮助下，用莲花罩住狮魔，迫使狮魔现出原形，终于收服。"},{"url":"http://p9.pstatp.com/origin/pgc-image/1e1eafc38ef54389a01403847e421bd6","width":363,"url_list":[{"url":"http://p9.pstatp.com/origin/pgc-image/1e1eafc38ef54389a01403847e421bd6"},{"url":"http://pb1.pstatp.com/origin/pgc-image/1e1eafc38ef54389a01403847e421bd6"},{"url":"http://pb3.pstatp.com/origin/pgc-image/1e1eafc38ef54389a01403847e421bd6"}],"uri":"origin/pgc-image/1e1eafc38ef54389a01403847e421bd6","height":384,"content":" 白鹿精：本是南极寿星的坐骑，一日趁寿星不注意，偷得寿星的蟠龙拐杖作为兵器，下界收狐狸精为女儿，并将她献给了比丘国国王，自己当起国丈来，常用小孩心肝作为药引子，以求千年不老。唐僧看见于心不忍，让孙悟空解救无辜的孩童。孙悟空神勇无比，白鹿精哪里抵得住神出鬼没的如意金箍棒，悟空、八戒齐心协力，捣毁妖精魔穴，正要打杀鹿精变成的国丈时，南极寿星赶到，迫使国丈现出白鹿的本相，收伏了白鹿。"},{"url":"http://p1.pstatp.com/origin/pgc-image/2c48a5572c294cd9b7c2e5330e7684d0","width":363,"url_list":[{"url":"http://p1.pstatp.com/origin/pgc-image/2c48a5572c294cd9b7c2e5330e7684d0"},{"url":"http://pb3.pstatp.com/origin/pgc-image/2c48a5572c294cd9b7c2e5330e7684d0"},{"url":"http://pb9.pstatp.com/origin/pgc-image/2c48a5572c294cd9b7c2e5330e7684d0"}],"uri":"origin/pgc-image/2c48a5572c294cd9b7c2e5330e7684d0","height":384,"content":"蝎子精：本是琵琶大小的蝎子，修行多年。她使用一柄三股钢叉，鼻中喷火，口中吐烟，十分厉害，她用法术卷走唐僧，欲成夫妻美事，又屡屡打败孙悟空、八戒。最后，孙悟空上天从光明宫搬来昴日星官，星官等孙悟空诱出妖精，变成六七尺高的双冠子大公鸡，一声啼鸣，使妖精现出原形，被八戒捣成一团烂酱，真是罪有应得。"},{"url":"http://p3.pstatp.com/origin/pgc-image/692a06d5c7e548f38a779fac78240ac0","width":363,"url_list":[{"url":"http://p3.pstatp.com/origin/pgc-image/692a06d5c7e548f38a779fac78240ac0"},{"url":"http://pb9.pstatp.com/origin/pgc-image/692a06d5c7e548f38a779fac78240ac0"},{"url":"http://pb1.pstatp.com/origin/pgc-image/692a06d5c7e548f38a779fac78240ac0"}],"uri":"origin/pgc-image/692a06d5c7e548f38a779fac78240ac0","height":384,"content":"黄袍怪：居住在碗子山波月洞，原是天上二十八宿的奎星，也就是奎木狼，因在天宫与披香殿侍香的玉女交了朋友，思凡下界，占山为怪，与玉女作了十三年的夫妻。唐僧师徒去西天取经，路过碗子山，被黄袍怪捉住。八戒与沙僧两人合力与他拼斗，还是难敌黄袍怪那柄钢刀，就连悟空也和他打了个平手。玉帝知道黄袍怪是奎星下凡，命二十七宿星员下界收服黄袍怪，贬奎星为太上老君烧火，带俸操作；有功复职，无功便罪加一等。"},{"url":"http://p1.pstatp.com/origin/pgc-image/5dce1ddd12e84038a62dbfc974be4d55","width":363,"url_list":[{"url":"http://p1.pstatp.com/origin/pgc-image/5dce1ddd12e84038a62dbfc974be4d55"},{"url":"http://pb3.pstatp.com/origin/pgc-image/5dce1ddd12e84038a62dbfc974be4d55"},{"url":"http://pb9.pstatp.com/origin/pgc-image/5dce1ddd12e84038a62dbfc974be4d55"}],"uri":"origin/pgc-image/5dce1ddd12e84038a62dbfc974be4d55","height":384,"content":"九头怪：本是九头虫修行成精，手使一柄月牙铲，更奇的是长了九个头，是乱石山碧波潭的万圣老龙的驸马，他盗走祭赛国金光寺的舍利子佛宝，又偷了王母娘娘的九叶灵芝草，嫁祸给金光寺的和尚。唐僧师徒知道后，决心追回佛宝，为佛门弟子讨个清白，在二郎真君的帮助下，打败了九头怪，追回了舍利子佛宝和九叶灵芝草，救了金光寺的和尚。\n"},{"url":"http://p9.pstatp.com/origin/pgc-image/1685ee7021764201a1601fed164f2ac5","width":363,"url_list":[{"url":"http://p9.pstatp.com/origin/pgc-image/1685ee7021764201a1601fed164f2ac5"},{"url":"http://pb1.pstatp.com/origin/pgc-image/1685ee7021764201a1601fed164f2ac5"},{"url":"http://pb3.pstatp.com/origin/pgc-image/1685ee7021764201a1601fed164f2ac5"}],"uri":"origin/pgc-image/1685ee7021764201a1601fed164f2ac5","height":384,"content":"狮驼洞三大王：狮驼洞老妖原是文殊菩萨的坐骑，青毛狮子，成精下凡。狮驼洞二怪本是峨眉山普贤菩萨的坐骑白象，身高三丈，手使一柄长枪。狮驼洞三怪原是只大鹏金翅鹊，名号云程万里鹏，手使方天画戟，又有稀世之宝阴阳瓶，心计狡诈，神勇非凡。"},{"url":"http://p9.pstatp.com/origin/pgc-image/7fcbc9bbb0944a439c5733a177993f11","width":363,"url_list":[{"url":"http://p9.pstatp.com/origin/pgc-image/7fcbc9bbb0944a439c5733a177993f11"},{"url":"http://pb1.pstatp.com/origin/pgc-image/7fcbc9bbb0944a439c5733a177993f11"},{"url":"http://pb3.pstatp.com/origin/pgc-image/7fcbc9bbb0944a439c5733a177993f11"}],"uri":"origin/pgc-image/7fcbc9bbb0944a439c5733a177993f11","height":384,"content":"犼子怪：住在麒麟山獬豸洞，号称赛太岁，原本是观音菩萨胯下的金毛。它手使一柄宣花大斧，三个宝贝金铃更是历害无比。一次趁牧童打盹儿之机，咬断铁索，下界来到麒麟山，抢走朱紫国东宫金圣娘娘，要行百年之好，无奈金圣娘娘穿着带毒刺的新衣服，使妖怪不能近身。孙悟空最后骗取妖怪的宝贝金铃，打败妖怪。"},{"url":"http://p3.pstatp.com/origin/pgc-image/b9a0dbf2600e4005b9f4b5cc841281e5","width":363,"url_list":[{"url":"http://p3.pstatp.com/origin/pgc-image/b9a0dbf2600e4005b9f4b5cc841281e5"},{"url":"http://pb9.pstatp.com/origin/pgc-image/b9a0dbf2600e4005b9f4b5cc841281e5"},{"url":"http://pb1.pstatp.com/origin/pgc-image/b9a0dbf2600e4005b9f4b5cc841281e5"}],"uri":"origin/pgc-image/b9a0dbf2600e4005b9f4b5cc841281e5","height":384,"content":" 红蟒精：本是一条大红蟒，手使两杆轻柄枪，两只眼睛像灯笼，常在稀柿兴妖作怪，吞吃人畜不吐骨头，遇上神通广大的孙悟空，却不经打，现出原形，一口吃了孙悟空，谁知正中孙悟空的下怀。孙悟空在红蟒精的肚子里大耍威风，把蟒精整治得没有办法，孙悟空还不罢休，用金箍棒戳破蟒精的肚皮，使妖精一命呜呼，为当地百姓除了一害。"},{"url":"http://p1.pstatp.com/origin/pgc-image/ee02382bfb76499ba49371b9ab21a616","width":363,"url_list":[{"url":"http://p1.pstatp.com/origin/pgc-image/ee02382bfb76499ba49371b9ab21a616"},{"url":"http://pb3.pstatp.com/origin/pgc-image/ee02382bfb76499ba49371b9ab21a616"},{"url":"http://pb9.pstatp.com/origin/pgc-image/ee02382bfb76499ba49371b9ab21a616"}],"uri":"origin/pgc-image/ee02382bfb76499ba49371b9ab21a616","height":384,"content":"玄英洞三妖魔：叫辟寒大王、辟暑大王、辟尘大王，都是修行多年的犀牛精。辟寒大王手使一把钺斧，是妖精的魔头，辟暑大王使用一杆大刀，辟尘大王使的是少见的奇挞藤，三妖怪都能飞云步雾，多种变化。三妖魔设计捉住唐僧，后被孙悟空请来的四木禽星捉拿。"},{"url":"http://p1.pstatp.com/origin/pgc-image/0e3ff76b262249b7a0bca8812490a693","width":363,"url_list":[{"url":"http://p1.pstatp.com/origin/pgc-image/0e3ff76b262249b7a0bca8812490a693"},{"url":"http://pb3.pstatp.com/origin/pgc-image/0e3ff76b262249b7a0bca8812490a693"},{"url":"http://pb9.pstatp.com/origin/pgc-image/0e3ff76b262249b7a0bca8812490a693"}],"uri":"origin/pgc-image/0e3ff76b262249b7a0bca8812490a693","height":384,"content":"蜘蛛精：盘丝洞的女妖精是七个得道的蜘蛛精，号称七仙姑。她们使用的都是三尺宝剑，经常变成美女兴妖作怪，祸害人畜，打斗激烈时，就敞开怀，露出雪白的肚子，肚脐眼丝绳乱冒。她们用这个法术捉住唐僧和八戒，想吃圣僧的肉长生不老。幸好孙悟空，施展本领救出师父，不料唐僧又落入蜘蛛精师兄多目怪手中，孙悟空气愤之极，拔了一把毫毛，吹口仙气，变成七十二个小行者，一阵乱打，把七个蜘蛛精打成烂泥，除去取经途中一大害。"},{"url":"http://p1.pstatp.com/origin/pgc-image/9f9ce8f35c274517a70eedf540db1ab3","width":363,"url_list":[{"url":"http://p1.pstatp.com/origin/pgc-image/9f9ce8f35c274517a70eedf540db1ab3"},{"url":"http://pb3.pstatp.com/origin/pgc-image/9f9ce8f35c274517a70eedf540db1ab3"},{"url":"http://pb9.pstatp.com/origin/pgc-image/9f9ce8f35c274517a70eedf540db1ab3"}],"uri":"origin/pgc-image/9f9ce8f35c274517a70eedf540db1ab3","height":384,"content":"玉兔精：原是广寒宫捣药的玉兔，为报私仇思凡下界。她摄去天竺国公主，扮成假公主。知道唐僧取经要路经天竺国，想招圣僧为丈夫，多亏孙悟空火眼金睛，识破妖精的真相，两人一场大战，不分胜败。孙悟空扔起金箍棒，打得妖怪化作清风，逃到南天门上，孙悟空紧追不舍，又打回地上，妖怪难敌悟空的如意金箍棒。正当招架不住时，太阴星君和嫦娥仙子赶到，带回天宫。"},{"url":"http://p3.pstatp.com/origin/pgc-image/97c6aec82444426f8100abb13ba29656","width":363,"url_list":[{"url":"http://p3.pstatp.com/origin/pgc-image/97c6aec82444426f8100abb13ba29656"},{"url":"http://pb9.pstatp.com/origin/pgc-image/97c6aec82444426f8100abb13ba29656"},{"url":"http://pb1.pstatp.com/origin/pgc-image/97c6aec82444426f8100abb13ba29656"}],"uri":"origin/pgc-image/97c6aec82444426f8100abb13ba29656","height":384,"content":" 金鼻白毛老鼠精：叫作地涌夫人。老鼠精手使两口宝剑，变化多端，化为狂风卷走唐僧，想与圣僧结为百年之好。结果孙悟空变成桃子，钻进妖精肚子，抡拳跳腾，差点儿把妖精肚皮捣破，只好放开唐僧，待到悟空出来便拔出双剑与悟空一决高下。结果妖怪趁悟空不注意又变成清风，又抢走唐僧，气得悟空跑到天宫告状，玉帝派托塔天王父子下界捉拿妖精，用缚妖索捆住妖怪，回天宫向玉帝复命，唐僧由此度过了一难。"},{"url":"http://p1.pstatp.com/origin/pgc-image/4ac0c16c28d84b9ca1e67a7a902d56a1","width":363,"url_list":[{"url":"http://p1.pstatp.com/origin/pgc-image/4ac0c16c28d84b9ca1e67a7a902d56a1"},{"url":"http://pb3.pstatp.com/origin/pgc-image/4ac0c16c28d84b9ca1e67a7a902d56a1"},{"url":"http://pb9.pstatp.com/origin/pgc-image/4ac0c16c28d84b9ca1e67a7a902d56a1"}],"uri":"origin/pgc-image/4ac0c16c28d84b9ca1e67a7a902d56a1","height":384,"content":" 铁扇公主、牛魔王：铁扇公主又叫罗刹女，是女妖中十分厉害的一个，长得漂亮俊俏，与牛魔王是夫妻。"},{"url":"http://p3.pstatp.com/origin/pgc-image/7cb14fa299b848369beb31f5efa61e78","width":363,"url_list":[{"url":"http://p3.pstatp.com/origin/pgc-image/7cb14fa299b848369beb31f5efa61e78"},{"url":"http://pb9.pstatp.com/origin/pgc-image/7cb14fa299b848369beb31f5efa61e78"},{"url":"http://pb1.pstatp.com/origin/pgc-image/7cb14fa299b848369beb31f5efa61e78"}],"uri":"origin/pgc-image/7cb14fa299b848369beb31f5efa61e78","height":384,"content":"虎力、鹿力、羊力三大仙：虎力大仙、鹿力大仙、羊力大仙，是唐僧师徒取经时，路过车迟国遇到的三个妖怪，他们本是山中成精的野兽：是黄虎、白鹿和羚羊。这三个成精的山兽，以妖术骗过了车迟国君臣，当上了国师。后与孙悟空的斗法中，全部阵亡，可惜修行多年的精怪，不务正道，落了个自取灭亡。"}]

				return {:code => 0, :message => "SUCCESS", :data => json}
			end

			desc "抖音热点视频"
			params do
			end
			get :dyvideohot do
				result = Utils::Helper::get("http://api.tianapi.com/txapi/dyvideohot/index?key=5a34f94c61ecb00817ee7248b096681d")

				return {:code => 0, :message => result["msg"], :data => result["newslist"].as_json()}
			end

    end
  end
end
