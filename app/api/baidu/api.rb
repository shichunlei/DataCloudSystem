module BAIDU

	module ErrorFormatter
    def self.call message, backtrace, options, env
      {:code => '20000', :message => message}.to_json
    end
	end

	class API < Grape::API
		format :json
		content_type :json, "application/json"
		error_formatter :json, ErrorFormatter

		mount BAIDU::Ocr
		mount BAIDU::Image
		mount BAIDU::Nlp
		mount BAIDU::Util
	end

	# 返回码
	# 20001 成功
	# 20002 错误
end
