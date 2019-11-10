module V1
	class Sports < Grape::API

    include Utils

		resource :sports do

      desc "NBA球队阵容"
      params do
        requires :id, type: Integer, desc: '球队ID'
      end
      get :team_roster do
        _ = Time.now.to_i

        body = Utils::Helper::getHttpBody("https://matchweb.sports.qq.com/team/players?&callback=jQueryTeamRoster_#{_}&teamId=#{params[:id]}&competitionId=100000&_=#{Time.now.to_i}")

        result = JSON.parse(body.gsub("jQueryTeamRoster_#{_}(", '').gsub(")", ''))

        return {:code => result['code'], :message => "SUCCESS", :data => result['data']}
      end

      desc "NBA球队赛程"
      params do
        requires :id, type: Integer, desc: '球队ID'
      end
      get :team_schedule do
        puts Time.now.to_i

        body = Utils::Helper::getHttpBody("https://matchweb.sports.qq.com/team/matchList?callback=getGameList&teamId=#{params[:id]}&competitionId=100000&_=#{Time.now.to_i}")

        result = JSON.parse(body.gsub("getGameList(", '').gsub(")", ''))

        data = []

        if result['code'] == 0
          result['data'].each do |key, value|
            m = {}
            m.store("m", key)
            m.store("list", value)
            data.push(m)
          end
        end

        return {:code => result['code'], :message => "SUCCESS", :data => data}
      end

      desc "NBA比赛本场概况（技术统计）"
      params do
        requires :mid, type: String, desc: '比赛ID'
      end
      get :match_stats do
        body = Utils::Helper::getHttpBody("https://matchweb.sports.qq.com/kbs/matchStat?mid=#{params[:mid]}&callback=matchStatsCallback0")

        result = JSON.parse(body.gsub("matchStatsCallback0(", '').gsub(")", ''))

        return {:code => result['code'], :message => "SUCCESS", :data => result['data']}
      end

      desc "NBA比赛本场集锦"
      params do
        requires :mid, type: String, desc: '比赛ID'
      end
      get :match_all_video do
        body = Utils::Helper::getHttpBody("https://matchweb.sports.qq.com/kbs/matchVideoAll?mid=#{params[:mid]}&callback=matchVideoAllVideo")

        result = JSON.parse(body.gsub("matchVideoAllVideo(", '').gsub(")", ''))

        return {:code => result['code'], :message => "SUCCESS", :data => result['data']}
      end

      desc "NBA比赛相关推荐"
      params do
        requires :mid, type: String, desc: '比赛ID'
      end
      get :related_news do
        body = Utils::Helper::getHttpBody("https://matchweb.sports.qq.com/kbs/matchNews?mid=#{params[:mid]}&callback=relatedNewsCallback")

        result = JSON.parse(body.gsub("relatedNewsCallback(", '').gsub(")", ''))

        return {:code => result['code'], :message => "SUCCESS", :data => result['data']}
      end

      desc "NBA比赛两队球队概况及交手情况"
      params do
        requires :mid, type: String, desc: '比赛ID'
      end
      get :fetch_match_history do
        puts Time.now.to_i

        body = Utils::Helper::getHttpBody("https://matchweb.sports.qq.com/kbs/matchHistoryData?mid=#{params[:mid]}&callback=fetchMatchHistoryDataCallback")

        result = JSON.parse(body.gsub("fetchMatchHistoryDataCallback(", '').gsub(")", ''))

        if result['code'] == 0
          leftInfo = Utils::Helper::getHttpBody("https://matchweb.sports.qq.com/team/baseInfo?teamId=#{result['data']['teamInfo']['leftId']}&competitionId=100000&from=web&callback=fetchTeamInfoCallbackleft")

          leftResult = JSON.parse(leftInfo.gsub("fetchTeamInfoCallbackleft(", '').gsub(")", ''))

          rightInfo = Utils::Helper::getHttpBody("https://matchweb.sports.qq.com/team/baseInfo?teamId=#{result['data']['teamInfo']['rightId']}&competitionId=100000&from=web&callback=fetchTeamInfoCallbackright")

          rightResult = JSON.parse(rightInfo.gsub("fetchTeamInfoCallbackright(", '').gsub(")", ''))

          result['data'].delete('teamInfo')

          teamInfo = {}

          teamInfo.store('right', rightResult['data'])
          teamInfo.store('left', leftResult['data'])
          result['data'].store('teamInfo', teamInfo)
        end

        return {:code => result['code'], :message => "SUCCESS", :data => result['data']}
      end

      desc "NBA球队详情"
      params do
        requires :id, type: Integer, desc: '球队ID'
      end
      get :team_info do
        puts Time.now.to_i

        body = Utils::Helper::getHttpBody("https://matchweb.sports.qq.com/team/baseInfo?callback=getTeamIntro&teamId=#{params[:id]}&competitionId=100000&from=web&_=#{Time.now.to_i}")

        result = JSON.parse(body.gsub("getTeamIntro(", '').gsub(")", ''))

        return {:code => result['code'], :message => "SUCCESS", :data => result['data']}
      end

      desc "NBA球队数据"
      params do
        requires :id, type: Integer, desc: '球队ID'
      end
      get :team_stats do
        puts Time.now.to_i

        body = Utils::Helper::getHttpBody("https://matchweb.sports.qq.com/team/stats?&callback=getTeamStats&teamId=#{params[:id]}&competitionId=100000&from=web&_=#{Time.now.to_i}")

        result = JSON.parse(body.gsub("getTeamStats(", '').gsub(")", ''))

        return {:code => result['code'], :message => "SUCCESS", :data => result['data']}
      end

      desc "NBA球队排名"
      params do
      end
      get :team_rank do
        _ = Time.now.to_i

        body = Utils::Helper::getHttpBody("https://matchweb.sports.qq.com/rank/team?from=sporthp&callback=jQueryTeamRank_#{_}&competitionId=100000&from=NBA_PC&_=#{Time.now.to_i}")

        result = JSON.parse(body.gsub("jQueryTeamRank_#{_}([0,", '').gsub(",\"\"]);", ''))

				data = []
				east = {}
				east.store("list", result['east'])
				east.store("title", "东部联盟")
				east.store("type", 1)
				data.push(east)

				west = {}
				west.store("list", result['west'])
				west.store("title", "西部联盟")
				west.store("type", 1)
				data.push(west)

				atlantic = {}
				atlantic.store("list", result['atlantic'])
				atlantic.store("title", "大西洋赛区")
				atlantic.store("type", 2)
				data.push(atlantic)

				eastsouth = {}
				eastsouth.store("list", result['eastsouth'])
				eastsouth.store("title", "东南赛区")
				eastsouth.store("type", 2)
				data.push(eastsouth)

				central = {}
				central.store("list", result['central'])
				central.store("title", "中部赛区")
				central.store("type", 2)
				data.push(central)

				pacific = {}
				pacific.store("list", result['pacific'])
				pacific.store("title", "太平洋赛区")
				pacific.store("type", 2)
				data.push(pacific)

				westnorth = {}
				westnorth.store("list", result['westnorth'])
				westnorth.store("title", "西北赛区")
				westnorth.store("type", 2)
				data.push(westnorth)

				westsouth = {}
				westsouth.store("list", result['westsouth'])
				westsouth.store("title", "西南赛区")
				westsouth.store("type", 2)
				data.push(westsouth)

        return {:code => '0', :message => "SUCCESS", :data => data}
      end

      desc "NBA球队数据排名（前五）"
      params do
        requires :year, type: Integer, desc: '赛纪年份'
        requires :type, type: String, desc: '类型' # 0 季前赛；1 常规赛；2 季后赛
      end
      get :team_range do
        _ = Time.now.to_i

        body = Utils::Helper::getHttpBody("https://ziliaoku.sports.qq.com/cube/index?cubeId=12&dimId=45,46,47,49,50,51&from=sportsdatabase&limit=5&params=t2:#{params[:year]}|t3:#{params[:type]}&callback=jQueryTeamRangeFive_#{_}&_=#{Time.now.to_i}")

        result = JSON.parse(body.gsub("jQueryTeamRangeFive_#{_}(", '').gsub(")", ''))

        return {:code => result['code'], :message => "SUCCESS", :data => result['data']}
      end

      desc "NBA球队数据排名"
      params do
        requires :year, type: Integer, desc: '赛纪年份'
        requires :type, type: String, desc: '类型' # 0 季前赛；1 常规赛；2 季后赛
        requires :alliance, type: String, desc: '联盟' # west,east 全联盟；west 西部联盟；east 东部联盟
      end
      get :team_range_all do
        _ = Time.now.to_i

        body = Utils::Helper::getHttpBody("https://ziliaoku.sports.qq.com/cube/index?cubeId=12&dimId=43&from=sportsdatabase&order=t60&params=t2:#{params[:year]}|t3:#{params[:type]}|t64:#{params[:alliance]}&callback=jQueryTeamRangeAll_#{_}&_=#{Time.now.to_i}")

        result = JSON.parse(body.gsub("jQueryTeamRangeAll_#{_}(", '').gsub(")", ''))

        return {:code => result['code'], :message => "SUCCESS", :data => result['data']['nbTeamSeasonStatRank']}
      end

      desc "NBA球员数据排名（前五）"
      params do
        requires :year, type: Integer, desc: '赛纪年份'
        requires :type, type: String, desc: '类型' # 0 季前赛；1 常规赛；2 季后赛
      end
      get :player_range do
        _ = Time.now.to_i

        body = Utils::Helper::getHttpBody("https://ziliaoku.sports.qq.com/cube/index?cubeId=10&dimId=53,54,55,56,57,58&from=sportsdatabase&limit=5&params=t2:#{params[:year]}|t3:#{params[:type]}&callback=jQueryPlayerRangeFive_#{_}&_=#{Time.now.to_i}")

        result = JSON.parse(body.gsub("jQueryPlayerRangeFive_#{_}(", '').gsub(")", ''))

        return {:code => result['code'], :message => "SUCCESS", :data => result['data']}
      end

      desc "NBA球员数据排名（全）"
      params do
        requires :year, type: Integer, desc: '赛纪年份'
        requires :type, type: String, desc: '类型' # 0 季前赛；1 常规赛；2 季后赛
        requires :page, type: Integer, desc: '页码'
        requires :limit, type: Integer, desc: '每页条数'
        requires :sort, type: String, desc: '排序方式' # 得分 t70；出手数 t83；命中率 t79；三分出手 t85；三分命中率 t80；罚球次数 t87；发球命中率 t81；篮板 t71；前场篮板 t77；后场篮板 t76；助攻 t68；抢断 t72；盖帽 t69；失误 t74；犯规 t73；场次 t5；上场时间 t78
      end
      get :player_range_all do
        _ = Time.now.to_i
        page = params[:page]
        limit = params[:limit]

        _limit = "#{(page-1)*limit},#{(page)*limit}"

        body = Utils::Helper::getHttpBody("https://ziliaoku.sports.qq.com/cube/index?cubeId=10&dimId=52&from=sportsdatabase&order=#{params[:sort]}&params=t2:#{params[:year]}|t3:#{params[:type]}|&limit=#{_limit}&callback=jQueryPlayerRangeAll_#{_}&_=#{Time.now.to_i}")

        result = JSON.parse(body.gsub("jQueryPlayerRangeAll_#{_}(", '').gsub(")", ''))

        return {:code => result['code'], :message => "SUCCESS", :data => result['data']['nbaPlayerSeasonStatRank']}
      end

      desc "NBA赛程"
      params do
        requires :startTime, type: String, desc: '开始日期'
        requires :endTime, type: String, desc: '结束日期'
      end
      get :nba_schedule do
        puts Time.now.strftime('%Y-%m-%d')

        body = Utils::Helper::getHttpBody("https://matchweb.sports.qq.com/matchUnion/list?today=#{Time.now.strftime('%Y-%m-%d')}&startTime=#{params[:startTime]}&endTime=#{params[:endTime]}&columnId=100000&index=3&isInit=true&timestamp=#{Time.now.to_i}&callback=fetchScheduleListCallback100000")

        result = JSON.parse(body.gsub("fetchScheduleListCallback100000(", '').gsub(")", ''))

        data = []

        if result['code'] == 0
          result['data'].each do |key, value|
            m = {}
            m.store("m", key)
            m.store("list", value)
            data.push(m)
          end
        end

        return {:code => result['code'], :message => "SUCCESS", :data => data}
      end

      desc "NBA球员详情"
      params do
        requires :id, type: String, desc: '球员ID'
        requires :year, type: Integer, desc: '年份'
      end
      get :player_info do
        _ = Time.now.to_i

        id = params[:id]

        data = {}

        # 基本信息
        info = Utils::Helper::getHttpBody("https://ziliaoku.sports.qq.com/cube/index?callback=jQueryPlayerDetail_#{_}&cubeId=8&dimId=5&params=t1:#{id}&from=sportsdatabase")

        info_result = JSON.parse(info.gsub("jQueryPlayerDetail_#{_}(", '').gsub(")", ''))

        if info_result['code'] == 0
          data.store("playerBaseInfo", info_result['data']['playerBaseInfo'])
          puts info_result['data']['playerBaseInfo']['position']

          # 同位置球员
          pos = Utils::Helper::getHttpBody("https://ziliaoku.sports.qq.com/cube/index?callback=jQueryPlayerPos_#{_+3}&cubeId=8&dimId=6&params=t21:#{info_result['data']['playerBaseInfo']['position']}&from=sportsdatabase")

          pos_result = JSON.parse(pos.gsub("jQueryPlayerPos_#{_+3}(", '').gsub(")", ''))

          data.store("nbaPlayerPos", pos_result['data']['nbaPlayerPos'])
        end

        # 数据统计
        stat = Utils::Helper::getHttpBody("https://ziliaoku.sports.qq.com/cube/index?callback=jQueryPlayerSeasonStat_#{_+5}&cubeId=10&dimId=9,10&params=t2:#{params[:year]}|t3:1|t1:#{id}&from=sportsdatabase")

        stat_result = JSON.parse(stat.gsub("jQueryPlayerSeasonStat_#{_+5}(", '').gsub(")", ''))

        if stat_result['code'] == 0
          data.store("nbaPlayerLeagueSeasonStat", stat_result['data']['nbaPlayerLeagueSeasonStat'])
          data.store("nbaPlayerSeasonStat", stat_result['data']['nbaPlayerSeasonStat'])
        end

        # 球员赛季比赛数据统计
        match_stat = Utils::Helper::getHttpBody("https://ziliaoku.sports.qq.com/cube/index?callback=jQueryPlayerMatch_#{_+7}&cubeId=9&dimId=7,8&params=t27:#{params[:year]}|t28:1|t1:#{id}&from=sportsdatabase")

        match_stat_result = JSON.parse(match_stat.gsub("jQueryPlayerMatch_#{_+7}(", '').gsub(")", ''))

        if stat_result['code'] == 0
          data.store("nbaPlayerMatch", match_stat_result['data']['nbaPlayerMatch'])
          data.store("nbaPlayerMatchSeason", match_stat_result['data']['nbaPlayerMatchSeason'])
        end

        return {:code => '0', :message => "SUCCESS", :data => data}
      end

      desc "热门赛事赛程"
      params do
        requires :startTime, type: String, desc: '开始日期'
        requires :endTime, type: String, desc: '结束日期'
      end
      get :hot_schedule do
        puts Time.now.strftime('%Y-%m-%d')

        body = Utils::Helper::getHttpBody("https://matchweb.sports.qq.com/matchUnion/list?today=#{Time.now.strftime('%Y-%m-%d')}&startTime=#{params[:startTime]}&endTime=#{params[:endTime]}&columnId=hot&index=3&isInit=true&timestamp=#{Time.now.to_i}&callback=fetchScheduleListCallbackhot")

        result = JSON.parse(body.gsub("fetchScheduleListCallbackhot(", '').gsub(")", ''))

        data = []

        if result['code'] == 0
          result['data'].each do |key, value|
            m = {}
            m.store("m", key)
            m.store("list", value)
            data.push(m)
          end
        end

        return {:code => result['code'], :message => "SUCCESS", :data => data}
      end

    end
  end
end
