require 'json'
require 'net/http'
require 'openssl'

module V1
	class Astros < Grape::API
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

    end
  end
end
