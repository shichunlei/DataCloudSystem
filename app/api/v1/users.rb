module V1
	class Users < Grape::API
		resource :users do

      desc "用户登陆"
      params do
        requires :mobile, type: String, desc: '用户注册手机号码'
        requires :password, type: String, desc: '用户登录密码'
      end
      post :login do
        mobile = params[:mobile]
        password = params[:password]

        user = User.find_by(mobile:mobile)
        if user.nil?
          return {"code" => 20005, "message" => "账号不存在"}
        else
          if user.valid_password?(password)
            return {"code" => 20001, "message" => "请求成功", :data => user.as_json()}
          else
            return {"code" => 20004, "message" => "密码错误"}
          end
        end
      end

    end
  end
end
