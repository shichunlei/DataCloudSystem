module WECHAT
	class Users < Grape::API
		resource :users do

			desc '修改密码'
			params do
				requires :identifier, type: String, desc: '手机号码'
				requires :old_password, type: String, desc: '旧密码'
				requires :password, type: String, desc: '新密码'
			end
			post :update_password do
				identifier = params[:identifier]
				old_password = params[:old_password]
				password = params[:password]

				user = User.find_by(mobile:identifier)
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
				requires :identifier, type: String, desc: '手机号码'
			end
			post :update_name do
				identifier = params[:identifier]
				name = params[:name]

				user = User.find_by(mobile:identifier)
				if user.nil?
					return {"code" => '1003', "message" => "用户不存在"}
				else
					user.name = name

					if user.save
						return {"code" => '0', "message" => "修改成功", :data => user.as_json(:only => [:id, :name, :mobile], :methods => [:avatar_url, :identifier])}
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
						return {"code" => '0', "message" => "注册成功", :data => user.as_json(:only => [:id, :name, :mobile], :methods => [:avatar_url, :identifier])}
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
						return {"code" => '0', "message" => "登录成功", :data => user.as_json(:only => [:id, :name, :mobile], :methods => [:avatar_url, :identifier])}
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
					return {"code" => '0', "message" => "登录成功", :data => user.as_json(:only => [:id, :name, :mobile], :methods => [:avatar_url, :identifier])}
				end
			end

			desc "修改头像"
			params do
				requires :identifier, type: String, desc: '手机号码'
				requires :avatar, type: File, desc: '头像'
			end
			post :update_avatar do
				avatar = params[:avatar]
				identifier = params[:identifier]

				user = User.find_by(mobile:identifier)
				if user.nil?
					return {"code" => '1', "message" => "用户不存在"}
				else
					if !avatar.blank?
						user.avatar = avatar[:tempfile]
						if user.save
							return {"code" => '0', "message" => "登录成功", :data => user.as_json(:only => [:id, :email, :name, :mobile], :methods => [:avatar_url, :identifier])}
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
				return {"code" => '0', "message" => "成功", :data => users.as_json(:only => [:id, :name, :mobile], :methods => [:avatar_url, :identifier])}
			end

			desc "注册联系人"
			params do
			end
			get :contacts do
				users = User.where(is_wechat_account:true)
				return {"code" => '0', "message" => "成功", :data => users.as_json(:only => [:id, :name, :mobile], :methods => [:avatar_url, :identifier])}
			end

			desc "添加消息"
			params do
				requires :identifier, type: String, desc: '消息接收者手机号码'
				requires :from_user, type: String, desc: '发送消息者手机号码'
				requires :reason, type: String, desc: '原因'
				requires :notify_type, type: String, desc: '类型'
				requires :status, type: String, desc: '状态'
			end
			post :add_notify do
				identifier = params[:identifier]
				from_user = params[:from_user]
				reason = params[:reason]
				notify_type = params[:notify_type]
				status = params[:status]

				user = User.find_by(mobile:identifier,is_wechat_account:true)
				if user.nil?
					return {"code" => '1003', "message" => "用户不存在"}
				else
					notification = Notification.find_by(user_id:user.id, notify_type:notify_type, from_user:from_user)

					if notification.nil?
						notification = Notification.new
					end

					notification.user_id = user.id
					notification.from_user = from_user
					notification.notify_type = notify_type
					notification.reason = reason
					notification.status = status

					if notification.save
						return {"code" => '0', "message" => "添加成功"}
					end
				end
			end

			desc "消息列表"
			params do
				requires :identifier, type: String, desc: '手机号码'
			end
			get :notifications do
				identifier = params[:identifier]

				user = User.find_by(mobile:identifier,is_wechat_account:true)
				if user.nil?
					return {"code" => '1003', "message" => "用户不存在"}
				else
					notifications = Notification.where("user_id = ? OR from_user = ?", user.id, identifier)

					return {"code" => '0', "message" => "成功", :data => notifications.as_json(:include => [:user => {:only => [:id, :mobile, :name], :methods => [:avatar_url, :identifier]}], :only => [:id, :notify_type, :reason, :status], :methods => [:created_time, :from])}
				end
			end

    end
  end
end
