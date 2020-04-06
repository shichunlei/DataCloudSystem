module BAIDU

	module ErrorFormatter
    def self.call message, backtrace, options, env, original_exception
      {:code => '20000', :message => message, :from => backtrace}.to_json
    end
	end

	class API < Grape::API
		format :json
		content_type :json, "application/json"
		error_formatter :json, ErrorFormatter

		mount BAIDU::Ocr
		mount BAIDU::Util
	end

	# 返回码
	# 20001 成功
	# 20002 错误
end
