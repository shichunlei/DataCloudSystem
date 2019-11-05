class Book < ApplicationRecord

  has_attached_file :image, {
    :styles => { :medium => "600x600>", :thumb => "200x200>" },
    :default_url => "",
    :storage => :ftp,
    :path => "/data_cloud_system/books/:attachment/:id/:style/:filename",
    :url => "#{ENV['FTP_URL']}/data_cloud_system/books/:attachment/:id/:style/:filename",
    :ftp_connect_timeout => 10,
    :ftp_ignore_failing_connections => true,
    :ftp_servers => [{
                        :host     => ENV['FTP_HOST'],
                        :user     => ENV['FTP_USER'],
                        :password => ENV['FTP_PASSWORD'],
                        :passive => true
                      }]
  }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  # add a delete_<asset_name> method:
  attr_accessor :delete_image
  before_validation { self.image.clear if self.delete_image == '1' }

  def image_url
    image.url(:medium)
  end

  def chapter_list
    list = BookDetail.where(book_id:self.id).order(:id).as_json(:only => [:chapter])
    arr = []
    list.each do |item|
      arr.push(item["chapter"])
    end
    chapters = []
    chapternames = arr.uniq
    chapternames.each do |item|
      chapter = {}
      chapter.store("chapter", item)
      object = BookDetail.where(chapter:item).order(:id).as_json(:only => [:id, :name])
      chapter.store("data", object)
      chapters.push(chapter)
    end
    return chapters.as_json()
  end
end
