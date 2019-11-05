source 'https://gems.ruby-china.com/'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

#RAILS应用配置,配置参数写在application.yml里面，但是不提交到git上面，
#保证配置参数的安全性
gem "figaro"
#postgresql 数据库驱动
gem "pg"
#登录，注册，找回密码，短信注册
gem 'devise'
#devise插件能够通过短信注册
# gem 'devise_mobile_confirmable'
#发送短信的插件
# gem 'sms_carrier'
#权限管理
gem 'cancancan'
#关联角色和用户
gem "rolify"
#数据权限，数据是否可见，父数据模型的条件子数据模型
gem 'acts_as_tenant' #for sub-domain
#方便远程部署的Gem包
gem 'mina'
#高效率的Rails服务器
gem 'puma', '~> 3.0'
#高效便捷的模板引擎
gem 'slim'
#分页插件
gem 'kaminari'
#字体图标库
gem 'font-awesome-sass',  '~> 4.3'
#后台启动，重启，停止管理
gem 'daemon-spawn'
#html表单插件
gem 'simple_form'
#上传图片
gem 'carrierwave'
gem 'carrierwave-upyun'
#权限认证中间件
gem 'omniauth'

gem 'record_tag_helper', '~> 1.0'
#admin-lte 生成器
gem 'adminlte-generators'

#pjax请求
gem "rack-pjax"

# 图片文件上传
gem "paperclip", git: "git://github.com/thoughtbot/paperclip.git"
gem 'paperclip-storage-ftp'

#提供API
gem 'grape'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
