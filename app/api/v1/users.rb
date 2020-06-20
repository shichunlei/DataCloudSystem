module V1
	class Users < Grape::API
		resource :users do

      desc "用户邮箱登陆"
      params do
        requires :email, type: String, desc: '邮箱'
        requires :password, type: String, desc: '用户登录密码'
      end
      post :login do
        email = params[:email]
        password = params[:password]

        user = User.find_by(email:email)
        if user.nil?
          user = User.new
					user.email = email
					user.password = password
					user.organization_id = 1
					if user.save
						user.add_role "memeber"
						return {"code" => '0', "message" => "登录成功", :data => user.as_json(:only => [:id, :email, :name, :mobile], :methods => [:avatar_url])}
					else
						return {"code" => '1', "message" => "登录失败"}
					end
        else
          if user.valid_password?(password)
            return {"code" => '0', "message" => "登录成功", :data => user.as_json(:only => [:id, :email, :name, :mobile], :methods => [:avatar_url])}
          else
            return {"code" => '1', "message" => "密码错误"}
          end
        end
      end

			desc '修改密码'
			params do
				requires :id, type: Integer, desc: '会员编号'
				requires :old_password, type: String, desc: '旧密码'
				requires :password, type: String, desc: '新密码'
			end
			post :update_password do
				member_id = params[:member_id]
				old_password = params[:old_password]
				password = params[:password]

				user = User.find_by(id:id)
				if user.valid_password?(old_password)
					user.password = password
					if user.save
						return {"code" => '0', "message" => "修改成功"}
					else
						return {"code" => '1', "message" => "修改失败"}
					end
				else
					return {"code" => '1', "message" => "密码错误"}
				end
			end

			desc "修改头像"
			params do
				requires :id, type: Integer, desc: '会员编号'
				requires :avatar, type: File, desc: '头像'
			end
			post :update_avatar do
				avatar = params[:avatar]
				id = params[:id]

				user = User.find_by(id:id)
				if user.nil?
					return {"code" => '1', "message" => "用户不存在"}
				else
					if !avatar.blank?
						user.avatar = avatar[:tempfile]
						if user.save
							return {"code" => '0', "message" => "登录成功", :data => user.as_json(:only => [:id, :email, :name, :mobile], :methods => [:avatar_url])}
						else
							return {"code" => '1', "message" => "修改失败！"}
						end
					else
						return {"code" => '1', "message" => "请选择头像"}
					end
				end
			end

			desc "修改用户信息"
			params do
				requires :id, type: Integer, desc: '邮箱'
			end
			post :update_info do


			desc "注册"
			params do
				requires :password, type: String, desc: '密码'
				requires :mobile, type: String, desc: '手机号码'
				optional :name, type: String, desc: '昵称', default: ""
				optional :avatar, type: File, desc: '头像', default: nil
			end
			post :register do
				mobile = params[:mobile]
				password = params[:password]
				avatar = params[:avatar]
				name = params[:name]

				user = User.find_by(mobile:mobile, is_wechat_account:true)
				if user.nil?
					user = User.new
					email = "#{mobile}@14cells.com"

					user.email = email
					user.mobile = mobile
					user.password = password
					user.organization_id = 1
					user.is_wechat_account = true
					if !avatar.blank?
						user.avatar = avatar[:tempfile]
					end
					if name.blank?
						user.name = mobile
					else
						user.name = name
					end

					if user.save
						user.add_role "memeber"
						return {"code" => '0', "message" => "注册成功", :data => user.as_json(:only => [:id, :name, :mobile], :methods => [:avatar_url, :identifier])}
					else
						return {"code" => '1', "message" => "注册失败"}
					end
				else
					return {"code" => '1001', "message" => "账号已经注册过了"}
				end
			end

    end
  end
end
