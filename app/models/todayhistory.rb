class Todayhistory < ApplicationRecord

  def history_date
    "#{self.year}-#{self.month}-#{self.day}"
  end
end
