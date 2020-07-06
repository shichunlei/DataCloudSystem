module V1

	module ErrorFormatter
    def self.call message, backtrace, options, env, original_exception
      {:code => '-1', :message => message, :from => backtrace}.to_json
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
		mount V1::Juzimi
		mount V1::Qdaily
		mount V1::TubiTV
		mount V1::Sports
		mount V1::Musics
		mount V1::Cnov
	end
end

# 极速数据    唐诗   KEY a8d949a2591c8d0f
# 极速数据    国家信息/笑话/天气/万年历/星座/周公解梦   KEY   1793aab537f9d9e9
# 极速数据    成语/汉语词典  KEY 21780e871d77bedf
