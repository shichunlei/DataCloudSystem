module V1

	module ErrorFormatter
      def self.call message, backtrace, options, env
        {:code => "-1", :message => message}.to_json
      end
	end

	class API < Grape::API
		format :json
		content_type :json, "application/json"
		error_formatter :json, ErrorFormatter

		mount V1::Users
		mount V1::Cars
		mount V1::Recipes
		mount V1::Educations
		mount V1::Entertainments
		mount V1::Astros
		mount V1::Meizi
	end

	# 返回码
	# 20001 成功
	# 20002 错误

	# 20003 账户未激活
	# 20004 密码错误
	# 20005 账号不存在
	# 20006 参数错误
end
