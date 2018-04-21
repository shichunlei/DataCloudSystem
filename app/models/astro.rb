class Astro < ApplicationRecord

  def year_fortune
    YearFortune.find_by(astro_id:self.id, year:Time.now.year).as_json(:except => [:created_at, :updated_at, :astro_id])
  end

  def month_fortune
    month = "#{Time.now.year}-#{Time.now.month}"
    MonthFortune.find_by(astro_id:self.id, mdate:month).as_json(:except => [:created_at, :updated_at, :astro_id])
  end

  def week_fortune
    today = Time.now.strftime("%Y-%m-%d")
    WeekFortune.find_by("astro_id = ? AND start_date <= ? AND end_date >= ?", self.id, today, today).as_json(:except => [:created_at, :updated_at, :astro_id])
  end

  def today_fortune
    today = Time.now.strftime("%Y-%m-%d")
    TodayFortune.find_by(astro_id:self.id, tdate:today).as_json(:except => [:created_at, :updated_at, :astro_id])
  end

  def tomorrow_fortune
    tomorrow = (Time.now + (24 * 60 * 60)).strftime("%Y-%m-%d")
    TomorrowFortune.find_by(astro_id:self.id, tdate:tomorrow).as_json(:except => [:created_at, :updated_at, :astro_id])
  end
end
