class Notification < ApplicationRecord
  belongs_to :user

  def created_time
    self.created_at.strftime("%Y-%m-%d %H:%M:%S")
  end

  def from
    user = User.find_by(mobile:from_user)

    return user.as_json(:only => [:id, :name, :mobile], :methods => [:avatar_url, :identifier])
  end
end
