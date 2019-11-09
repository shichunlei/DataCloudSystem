require 'openssl'
require 'base64'
require 'json'
require 'digest/md5'
require 'net/http'
require 'net/https'

module Utils
  module Helper

    # DES加密
    def Helper::encrypt(context)
      cipher = OpenSSL::Cipher::DES.new.encrypt.tap { |obj| obj.key = obj.iv = ENV['DES_KEY'].encode('utf-8') }
      (cipher.update(context) + cipher.final).unpack('H*')[0].upcase
    end

    # DES解密
    def Helper::decrypt(context)
      cipher = OpenSSL::Cipher::DES.new.decrypt.tap { |obj| obj.key = obj.iv = ENV['DES_KEY'].encode('utf-8') }
      cipher.update([context].pack('H*')) + cipher.final
    end

    def Helper::aes_encrypt(encrypted_string)
      aes = OpenSSL::Cipher::Cipher.new("AES-128-ECB")
      aes.encrypt
      aes.key = "1234567890123456"
      txt = aes.update(encrypted_string) << aes.final
      txt.unpack('H*')[0].upcase
    end

    def Helper::aes_dicrypt(dicrypted_string)
      aes = OpenSSL::Cipher::Cipher.new("AES-128-ECB")
      aes.decrypt
      aes.key = "1234567890123456"
      aes.update([dicrypted_string].pack('H*')) << aes.final
    end

    def Helper::md5(str)
      md5_str = Digest::MD5.hexdigest(str)
      return md5_str
    end

    def Helper::get(url, header = nil)
      uri = URI.parse(URI.escape(url))
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true if uri.scheme == "https"  # enable SSL/TLS
      https.verify_mode = OpenSSL::SSL::VERIFY_NONE #这个也很重要
      req = Net::HTTP::Get.new(uri.request_uri)
      body = https.request(req).body
      result = JSON.parse(body)
      # puts result
      return result
    end

    def Helper::post(url, params, header = nil)
      uri = URI.parse(url)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true if uri.scheme == "https"  # enable SSL/TLS
      https.verify_mode = OpenSSL::SSL::VERIFY_NONE #这个也很重要
      req = Net::HTTP::Post.new(uri.path, initheader = header ? header : {'Content-Type' => 'application/json; charset=utf-8'})
      req.set_form_data(params)
      body = https.request(req).body
      result = JSON.parse(body)
      # puts result
      return result
    end

    def Helper::format_datetime(datetime, format = "%Y-%m-%d %H:%M:%S")
      if datetime.blank?
        return '';
      else
        return DateTime.parse(datetime).strftime(format)
      end
    end

    def Helper::getHttpBody(url, header = nil)
      uri = URI.parse(URI.escape(url))
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true if uri.scheme == "https"  # enable SSL/TLS
      https.verify_mode = OpenSSL::SSL::VERIFY_NONE #这个也很重要
      req = Net::HTTP::Get.new(uri.request_uri)
      body = https.request(req).body
      return body
    end

  end
end
