class Huangli < ApplicationRecord

  def huangli_date
    "#{self.year}-#{self.month}-#{self.day}"
  end
end
