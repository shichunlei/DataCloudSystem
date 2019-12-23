class User < ApplicationRecord
  rolify

  belongs_to :organization

  has_attached_file :avatar, {
    :styles => { :medium => "600x600>", :thumb => "300x300>" },
    :default_url => "",
    :storage => :ftp,
    :path => "/data_cloud_system/users/:attachment/:id/:style/:filename",
    :url => "#{ENV['FTP_URL']}data_cloud_system/users/:attachment/:id/:style/:filename",
    :ftp_connect_timeout => 10,
    :ftp_ignore_failing_connections => true,
    :ftp_servers => [{
                        :host     => ENV['FTP_HOST'],
                        :user     => ENV['FTP_USER'],
                        :password => ENV['FTP_PASSWORD'],
                        :passive => true
                      }]
  }
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  # add a delete_<asset_name> method:
  attr_accessor :delete_avatar
  before_validation { self.avatar.clear if self.delete_avatar == '1' }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def avatar_url
    avatar.url(:medium)
  end
end
