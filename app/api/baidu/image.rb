require 'json'
require 'net/http'
require 'openssl'
require 'open-uri'
require 'base64'

module BAIDU
	class Image < Grape::API
    include Utils
    resource :image do
      
    end
  end
end
