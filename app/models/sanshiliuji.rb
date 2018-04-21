class Sanshiliuji < ApplicationRecord

  has_attached_file :gallery, {
    :styles => { :medium => "1000x500>", :thumb => "500x300>" },
    :default_url => "",
    :storage => :ftp,
    :path => "/data_cloud_system/36ji/:attachment/:id/:style/:filename",
    :url => "http://101.200.174.126:10000/data_cloud_system/36ji/:attachment/:id/:style/:filename",
    :ftp_connect_timeout => 10,
    :ftp_ignore_failing_connections => true,
    :ftp_servers => [{
                        :host     => '101.200.174.126',
                        :user     => 'ftp',
                        :password => 'ftp!@#$',
                        :passive => true
                      }]
  }
  validates_attachment_content_type :gallery, :content_type => /\Aimage\/.*\Z/
  # add a delete_<asset_name> method:
  attr_accessor :delete_gallery
  before_validation { self.gallery.clear if self.delete_gallery == '1' }

  def gallery_url
    gallery.url(:medium).html_safe
  end
end
