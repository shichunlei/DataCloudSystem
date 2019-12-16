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
		mount V1::Astros
		mount V1::Movies
		mount V1::Meizi
		mount V1::Juzimi
		mount V1::Qdaily
		mount V1::TubiTV
		mount V1::Sports
		mount V1::Music
	end

	# 返回码
	# 20001 成功
	# 20002 错误
end
