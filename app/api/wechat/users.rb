module WECHAT
	class Users < Grape::API
		resource :users do

			desc '修改密码'
			params do
				requires :mobile, type: String, desc: '手机号码'
				requires :old_password, type: String, desc: '旧密码'
				requires :password, type: String, desc: '新密码'
			end
			post :update_password do
				mobile = params[:mobile]
				old_password = params[:old_password]
				password = params[:password]

				user = User.find_by(mobile:mobile)
				if user.valid_password?(old_password)
					user.password = password
					if user.save
						return {"code" => '0', "message" => "修改成功"}
					else
						return {"code" => '1', "message" => "修改失败"}
					end
				else
					return {"code" => '1004', "message" => "密码错误"}
				end
			end

			desc "修改昵称"
			params do
				requires :name, type: String, desc: '昵称'
				requires :mobile, type: String, desc: '手机号码'
			end
			post :update_name do
				mobile = params[:mobile]
				name = params[:name]

				user = User.find_by(mobile:mobile)
				if user.nil?
					return {"code" => '1003', "message" => "用户不存在"}
				else
					user.name = name

					if user.save
						return {"code" => '0', "message" => "修改成功", :data => user.as_json(:only => [:id, :name, :mobile], :methods => [:avatar_url])}
					else
						return {"code" => '1', "message" => "修改失败！"}
					end
				end
			end

			desc "注册"
			params do
				requires :password, type: String, desc: '密码'
				requires :mobile, type: String, desc: '手机号码'
				optional :name, type: String, desc: '昵称'
				optional :avatar, type: File, desc: '头像'
			end
			post :register do
				mobile = params[:mobile]
				password = params[:password]
				avatar = params[:avatar]
				name = params[:name]

				user = User.find_by(mobile:mobile)
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
					if !name.blank?
						user.name = name
					end

					if user.save
						user.add_role "memeber"
						return {"code" => '0', "message" => "注册成功", :data => user.as_json(:only => [:id, :name, :mobile], :methods => [:avatar_url])}
					else
						return {"code" => '1', "message" => "注册失败"}
					end
				else
					return {"code" => '1001', "message" => "账号已经注册过了"}
				end
			end

			desc "手机号码登陆"
			params do
				requires :mobile, type: String, desc: '手机号码'
				requires :password, type: String, desc: '用户登录密码'
			end
			post :login do
				mobile = params[:mobile]
				password = params[:password]

				user = User.find_by(mobile:mobile)
				if user.nil?
					return {"code" => '1003', "message" => "用户不存在"}
				else
					if user.valid_password?(password)
						return {"code" => '0', "message" => "登录成功", :data => user.as_json(:only => [:id, :name, :mobile], :methods => [:avatar_url])}
					else
						return {"code" => '1004', "message" => "密码错误"}
					end
				end
			end

			desc "验证码登陆"
			params do
				requires :mobile, type: String, desc: '手机号码'
				requires :code, type: String, desc: '验证码'
			end
			post :login_quickly do
				mobile = params[:mobile]

				user = User.find_by(mobile:mobile)
				if user.nil?
					return {"code" => '1003', "message" => "用户不存在"}
				else
					return {"code" => '0', "message" => "登录成功", :data => user.as_json(:only => [:id, :name, :mobile], :methods => [:avatar_url])}
				end
			end

			desc "修改头像"
			params do
				requires :mobile, type: String, desc: '手机号码'
				requires :avatar, type: File, desc: '头像'
			end
			post :update_avatar do
				avatar = params[:avatar]
				mobile = params[:mobile]

				user = User.find_by(mobile:mobile)
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
						return {"code" => '1005', "message" => "请选择头像"}
					end
				end
			end

			desc "搜索联系人"
			params do
				requires :mobile, type: String, desc: '手机号码'
			end
			get :search_contacts do
				mobile = params[:mobile]

				users = User.where(mobile:mobile,is_wechat_account:true)
				return {"code" => '0', "message" => "成功", :data => users.as_json(:only => [:id, :name, :mobile], :methods => [:avatar_url])}
			end

			desc "注册联系人"
			params do
			end
			get :contacts do
				users = User.where(is_wechat_account:true)
				return {"code" => '0', "message" => "成功", :data => users.as_json(:only => [:id, :name, :mobile], :methods => [:avatar_url])}
			end



    end
  end
end
