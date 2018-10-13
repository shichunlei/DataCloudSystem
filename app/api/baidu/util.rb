module BAIDU
	class Util < Grape::API
    include Utils
    resource :util do

      desc "获取Access Token"
      params do
      end
			get :oauth_token do
        params = {
          :grant_type => "client_credentials",
          :client_id => ENV['BAIDU_API_KEY'],
          :client_secret => ENV['BAIDU_SECRET_KEY']
        }
        result = Utils::Helper::post("#{ENV['BAIDU_HTTP_URL']}/oauth/2.0/token", params)

        if !result.has_key?("error")
          return {:code => 20001, :data => result.as_json()}
        else
          return {:code => result['error'], :message => result['error_description']}
        end
      end

    end
  end
end
