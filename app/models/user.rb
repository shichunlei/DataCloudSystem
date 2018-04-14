class User < ApplicationRecord
  rolify

  has_attached_file :avatar, {
    :styles => { :medium => "600x600>", :thumb => "300x300>" },
    :default_url => "http://101.200.174.126:9898/assets/images/head.png",
    :storage => :ftp,
    :path => "/nursing_cloud/user/:attachment/:id/:style/:filename",
    :url => "http://101.200.174.126:10000/nursing_cloud/user/:attachment/:id/:style/:filename",
    :ftp_connect_timeout => 10,
    :ftp_ignore_failing_connections => true,
    :ftp_servers => [{
                        :host     => '101.200.174.126',
                        :user     => 'ftp',
                        :password => 'ftp!@#$',
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
    avatar.url(:medium).html_safe
  end
end
