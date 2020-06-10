module WECHAT

	module ErrorFormatter
    def self.call message, backtrace, options, env, original_exception
      {:code => '-1', :message => message, :from => backtrace}.to_json
    end
	end

	class API < Grape::API
		format :json
		content_type :json, "application/json"
		error_formatter :json, ErrorFormatter

		mount WECHAT::Users
	end
end
