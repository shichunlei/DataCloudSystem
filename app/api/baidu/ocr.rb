# 接口名称											接口能力简要描述
# 通用文字识别									识别图片中的文字信息
# 通用文字识别（高精度版）				更高精度地识别图片中的文字信息
# 通用文字识别（含位置信息版）		识别图片中的文字信息（包含文字区域的坐标信息）
# 通用文字识别（高精度含位置版）		更高精度地识别图片中的文字信息（包含文字区域的坐标信息）
# 通用文字识别（含生僻字版）			识别图片中的文字信息（包含对常见字和生僻字的识别）
# 网络图片文字识别							识别一些网络上背景复杂，特殊字体的文字
# 手写识别											识别手写中文汉字或数字
# 身份证识别												识别身份证正反面的文字信息
# 银行卡识别												识别银行卡的卡号并返回发卡行和卡片性质信息
# 驾驶证识别												识别机动车驾驶证所有关键字段
# 行驶证识别												识别机动车行驶证所有关键字段
# 车牌识别												对大陆车牌（包含新能源车牌）进行识别
# 营业执照识别												对营业执照进行识别
# 护照识别												支持对中国大陆居民护照的资料页进行结构化识别，包含国家码、姓名、性别、护照号、出生日期、签发日期、有效期至、签发地点
# 名片识别												提供对各类名片的结构化识别功能，提取姓名、邮编、邮箱、电话、网址、地址、手机号字段
# 表格文字识别 （异步接口）	       自动识别表格线及表格内容，结构化输出表头、表尾及每个单元格的文字内容，提交图像和获取结果通过两个接口实现，稳定性更高
# 表格文字识别 （同步接口）	        自动识别表格线及表格内容，结构化输出表头、表尾及每个单元格的文字内容，提交图像后实时获得返回结果，实效性更好
# 通用票据识别												对各类票据图片（医疗票据，保险保单等）进行文字识别，并返回文字在图片中的位置信息
# 增值税发票识别												对增值税发票进行文字识别，并结构化返回字段信息，支持增值税专票、普票、电子发票
# 火车票识别												支持对大陆火车票的车票号、始发站、目的站、车次、日期、票价、席别、姓名进行结构化识别
# 出租车票识别												针对出租车票（现支持北京）的发票号码、发票代码、车号、日期、时间、金额进行结构化识别
# 二维码识别												识别条形码、二维码中包含的URL或其他信息内容
# 数字识别												对图像中的阿拉伯数字进行识别提取，适用于快递单号、手机号、充值码提取等场景
# 彩票识别												对大乐透、双色球彩票进行识别，并按行返回识别结果
# 自定义模板文字识别	              自定义模板文字识别可以通过自助的模板制作，建立起键值的对应关系，一步完成非结构化到结构化的转换，实现自动化的数据录入


require 'base64'

module BAIDU
	class Ocr < Grape::API
    include Utils
    resource :ocr do

			desc "通用文字识别"
      params do
				requires :access_token, type: String, desc: 'Access Token'
				optional :image, type: File, desc: '照片文件'
				optional :image_url, type: String, desc: '照片URL'
				optional :language_type, type: String, desc: '识别语言类型'
				optional :detect_direction, type: Boolean, desc: '是否检测图像朝向'
				optional :detect_language, type: Boolean, desc: '是否检测语言'
				optional :probability, type: Boolean, desc: '是否返回识别结果中每一行的置信度'
      end
			post :general_basic do
				image = params[:image]
				image_url = params[:image_url]

				if image.blank? && image_url.blank?
					return {:code => 20002, :message => "通用文字照片文件或照片URL至少上传一种！"}
				else
					access_token = params[:access_token]
					# 25.522d32555f292c43d9789ec375a1b1ba.315360000.1854595288.282335-14387235
					language_type = params[:language_type]
					detect_direction = params[:detect_direction]
					detect_language = params[:detect_language]
					probability = params[:probability]

					if !image_url.blank?
						tempfile = open(image_url)
					end

					if !image.blank?
						tempfile = image.tempfile
					end

					image_base64 = Base64.encode64(File.read(tempfile))
					tempfile.close

					header = {
						"Content-Type" => "application/x-www-form-urlencoded"
					}
					params = {
						:access_token => access_token,
						:image => image_base64,
						:language_type => language_type,
						:detect_direction => detect_direction,
						:detect_language => detect_language,
						:probability => probability
					}
					result = Utils::Helper::post("#{ENV['BAIDU_HTTP_URL']}/rest/2.0/ocr/v1/general_basic", params, header)

	        if !result.has_key?("error_code")
	          return {:code => 20001, :data => result.as_json()}
	        else
	          return {:code => result['error_code'], :message => result['error_msg']}
	        end
				end
			end

			desc "通用文字识别(高精度版)"
      params do
				requires :access_token, type: String, desc: 'Access Token'
				optional :image, type: File, desc: '照片文件'
				optional :image_url, type: String, desc: '照片URL'
				optional :detect_direction, type: Boolean, desc: '是否检测图像朝向'
				optional :probability, type: Boolean, desc: '是否返回识别结果中每一行的置信度'
      end
			post :accurate_basic do
				image = params[:image]
				image_url = params[:image_url]

				if image.blank? && image_url.blank?
					return {:code => 20002, :message => "通用文字照片文件或照片URL至少上传一种！"}
				else
					access_token = params[:access_token]
					# 25.522d32555f292c43d9789ec375a1b1ba.315360000.1854595288.282335-14387235
					detect_direction = params[:detect_direction]
					probability = params[:probability]

					if !image_url.blank?
						tempfile = open(image_url)
					end

					if !image.blank?
						tempfile = image.tempfile
					end

					image_base64 = Base64.encode64(File.read(tempfile))
					tempfile.close

					header = {
						"Content-Type" => "application/x-www-form-urlencoded"
					}
	        params = {
						:access_token => access_token,
	          :detect_direction => detect_direction,
	          :probability => probability,
						:image => image_base64
	        }
	        result = Utils::Helper::post("#{ENV['BAIDU_HTTP_URL']}/rest/2.0/ocr/v1/accurate_basic", params, header)

	        if !result.has_key?("error_code")
	          return {:code => 20001, :data => result.as_json()}
	        else
	          return {:code => result['error_code'], :message => result['error_msg']}
	        end
				end
			end

			desc "通用文字识别（含位置信息版）"
      params do
				requires :access_token, type: String, desc: 'Access Token'
				optional :image, type: File, desc: '照片文件'
				optional :image_url, type: String, desc: '照片URL'
				optional :language_type, type: String, desc: '识别语言类型'
				optional :detect_direction, type: Boolean, desc: '是否检测图像朝向'
				optional :detect_language, type: Boolean, desc: '是否检测语言'
				optional :probability, type: Boolean, desc: '是否返回识别结果中每一行的置信度'
				optional :vertexes_location, type: Boolean, desc: '是否返回文字外接多边形顶点位置'
				optional :recognize_granularity, type: String, desc: '是否定位单字符位置'
      end
			post :general do
				image = params[:image]
				image_url = params[:image_url]

				if image.blank? && image_url.blank?
					return {:code => 20002, :message => "通用文字照片文件或照片URL至少上传一种！"}
				else
					access_token = params[:access_token]
					# 25.522d32555f292c43d9789ec375a1b1ba.315360000.1854595288.282335-14387235
					language_type = params[:language_type]
					detect_direction = params[:detect_direction]
					detect_language = params[:detect_language]
					probability = params[:probability]
					vertexes_location = params[:vertexes_location]
					recognize_granularity = params[:recognize_granularity]

					if !image_url.blank?
						tempfile = open(image_url)
					end

					if !image.blank?
						tempfile = image.tempfile
					end

					image_base64 = Base64.encode64(File.read(tempfile))
					tempfile.close

					header = {
						"Content-Type" => "application/x-www-form-urlencoded"
					}
					params = {
						:access_token => access_token,
						:image => image_base64,
						:language_type => language_type,
						:detect_direction => detect_direction,
						:detect_language => detect_language,
						:probability => probability,
						:vertexes_location => vertexes_location,
						:recognize_granularity => recognize_granularity
					}
					result = Utils::Helper::post("#{ENV['BAIDU_HTTP_URL']}/rest/2.0/ocr/v1/general", params, header)

	        if !result.has_key?("error_code")
	          return {:code => 20001, :data => result.as_json()}
	        else
	          return {:code => result['error_code'], :message => result['error_msg']}
	        end
				end
			end

			desc "通用文字识别(含位置高精度版)"
      params do
				requires :access_token, type: String, desc: 'Access Token'
				optional :image, type: File, desc: '照片文件'
				optional :image_url, type: String, desc: '照片URL'
				optional :detect_direction, type: Boolean, desc: '是否检测图像朝向'
				optional :probability, type: Boolean, desc: '是否返回识别结果中每一行的置信度'
				optional :recognize_granularity, type: String, desc: '是否定位单字符位置'
				optional :vertexes_location, type: Boolean, desc: '是否返回文字外接多边形顶点位置'
      end
			post :accurate do
				image = params[:image]
				image_url = params[:image_url]

				if image.blank? && image_url.blank?
					return {:code => 20002, :message => "通用文字照片文件或照片URL至少上传一种！"}
				else
					access_token = params[:access_token]
					# 25.522d32555f292c43d9789ec375a1b1ba.315360000.1854595288.282335-14387235
					detect_direction = params[:detect_direction]
					probability = params[:probability]
					vertexes_location = params[:vertexes_location]
					recognize_granularity = params[:recognize_granularity]

					if !image_url.blank?
						tempfile = open(image_url)
					end

					if !image.blank?
						tempfile = image.tempfile
					end

					image_base64 = Base64.encode64(File.read(tempfile))
					tempfile.close

					header = {
						"Content-Type" => "application/x-www-form-urlencoded"
					}
	        params = {
						:access_token => access_token,
	          :detect_direction => detect_direction,
	          :probability => probability,
						:image => image_base64,
						:vertexes_location => vertexes_location,
						:recognize_granularity => recognize_granularity
	        }
	        result = Utils::Helper::post("#{ENV['BAIDU_HTTP_URL']}/rest/2.0/ocr/v1/accurate", params, header)

	        if !result.has_key?("error_code")
	          return {:code => 20001, :data => result.as_json()}
	        else
	          return {:code => result['error_code'], :message => result['error_msg']}
	        end
				end
			end

			desc "通用文字识别（含生僻字版）"
      params do
				requires :access_token, type: String, desc: 'Access Token'
				optional :image, type: File, desc: '照片文件'
				optional :image_url, type: String, desc: '照片URL'
				optional :language_type, type: String, desc: '识别语言类型'
				optional :detect_direction, type: Boolean, desc: '是否检测图像朝向'
				optional :detect_language, type: Boolean, desc: '是否检测语言'
				optional :probability, type: Boolean, desc: '是否返回识别结果中每一行的置信度'
      end
			post :general_enhanced do
				image = params[:image]
				image_url = params[:image_url]

				if image.blank? && image_url.blank?
					return {:code => 20002, :message => "通用文字照片文件或照片URL至少上传一种！"}
				else
					access_token = params[:access_token]
					# 25.522d32555f292c43d9789ec375a1b1ba.315360000.1854595288.282335-14387235
					language_type = params[:language_type]
					detect_direction = params[:detect_direction]
					detect_language = params[:detect_language]
					probability = params[:probability]

					if !image_url.blank?
						tempfile = open(image_url)
					end

					if !image.blank?
						tempfile = image.tempfile
					end

					image_base64 = Base64.encode64(File.read(tempfile))
					tempfile.close

					header = {
						"Content-Type" => "application/x-www-form-urlencoded"
					}
					params = {
						:access_token => access_token,
						:image => image_base64,
						:language_type => language_type,
						:detect_direction => detect_direction,
						:detect_language => detect_language,
						:probability => probability
					}
					result = Utils::Helper::post("#{ENV['BAIDU_HTTP_URL']}/rest/2.0/ocr/v1/general_enhanced", params, header)

	        if !result.has_key?("error_code")
	          return {:code => 20001, :data => result.as_json()}
	        else
	          return {:code => result['error_code'], :message => result['error_msg']}
	        end
				end
			end

			desc "网络图片文字识别"
      params do
				requires :access_token, type: String, desc: 'Access Token'
				optional :image, type: File, desc: '照片文件'
				optional :image_url, type: String, desc: '照片URL'
				optional :detect_direction, type: Boolean, desc: '是否检测图像朝向'
				optional :detect_language, type: Boolean, desc: '是否检测语言'
      end
			post :webimage do
				image = params[:image]
				image_url = params[:image_url]

				if image.blank? && image_url.blank?
					return {:code => 20002, :message => "通用文字照片文件或照片URL至少上传一种！"}
				else
					access_token = params[:access_token]
					# 25.522d32555f292c43d9789ec375a1b1ba.315360000.1854595288.282335-14387235
					detect_direction = params[:detect_direction]
					detect_language = params[:detect_language]

					if !image_url.blank?
						tempfile = open(image_url)
					end

					if !image.blank?
						tempfile = image.tempfile
					end

					image_base64 = Base64.encode64(File.read(tempfile))
					tempfile.close

					header = {
						"Content-Type" => "application/x-www-form-urlencoded"
					}
					params = {
						:access_token => access_token,
						:image => image_base64,
						:detect_direction => detect_direction,
						:detect_language => detect_language
					}
					result = Utils::Helper::post("#{ENV['BAIDU_HTTP_URL']}/rest/2.0/ocr/v1/webimage", params, header)

	        if !result.has_key?("error_code")
	          return {:code => 20001, :data => result.as_json()}
	        else
	          return {:code => result['error_code'], :message => result['error_msg']}
	        end
				end
			end

			desc "手写文字识别"
      params do
				requires :access_token, type: String, desc: 'Access Token'
				optional :image, type: File, desc: '照片文件'
				optional :image_url, type: String, desc: '照片URL'
				optional :recognize_granularity, type: String, desc: '是否定位单字符位置'
				optional :words_type, type: String, desc: '识别类型'
      end
			post :handwriting do
				image = params[:image]
				image_url = params[:image_url]

				if image.blank? && image_url.blank?
					return {:code => 20002, :message => "通用文字照片文件或照片URL至少上传一种！"}
				else
					access_token = params[:access_token]
					# 25.522d32555f292c43d9789ec375a1b1ba.315360000.1854595288.282335-14387235
					recognize_granularity = params[:recognize_granularity]
					words_type = params[:words_type]

					if !image_url.blank?
						tempfile = open(image_url)
					end

					if !image.blank?
						tempfile = image.tempfile
					end

					image_base64 = Base64.encode64(File.read(tempfile))
					tempfile.close

					header = {
						"Content-Type" => "application/x-www-form-urlencoded"
					}
	        params = {
						:access_token => access_token,
	          :recognize_granularity => recognize_granularity,
	          :words_type => words_type,
						:image => image_base64
	        }
	        result = Utils::Helper::post("#{ENV['BAIDU_HTTP_URL']}/rest/2.0/ocr/v1/handwriting", params, header)

	        if !result.has_key?("error_code")
	          return {:code => 20001, :data => result.as_json()}
	        else
	          return {:code => result['error_code'], :message => result['error_msg']}
	        end
				end
			end

			desc "身份证识别"
      params do
				requires :access_token, type: String, desc: 'Access Token'
				requires :detect_direction, type: Boolean, desc: '是否检测图像旋转角度'
				requires :id_card_side, type: String, desc: '身份证正面OR反面'
				optional :image, type: File, desc: '照片文件'
				optional :image_url, type: String, desc: '照片URL'
				requires :detect_risk, type: Boolean, desc: '是否开启身份证风险类型'
      end
			post :idcard do
				image = params[:image]
				image_url = params[:image_url]

				if image.blank? && image_url.blank?
					return {:code => 20002, :message => "身份证照片文件或照片URL至少上传一种！"}
				else
					detect_direction = params[:detect_direction]
					id_card_side = params[:id_card_side]
					detect_risk = params[:detect_risk]
					access_token = params[:access_token]
					# 25.522d32555f292c43d9789ec375a1b1ba.315360000.1854595288.282335-14387235

					if !image_url.blank?
						tempfile = open(image_url)
					end

					if !image.blank?
						tempfile = image.tempfile
					end

					image_base64 = Base64.encode64(File.read(tempfile))
					tempfile.close

					header = {
						"Content-Type" => "application/x-www-form-urlencoded"
					}
	        params = {
						:access_token => access_token,
	          :detect_direction => detect_direction,
	          :id_card_side => id_card_side,
	          :detect_risk => detect_risk,
						:image => image_base64
	        }
	        result = Utils::Helper::post("#{ENV['BAIDU_HTTP_URL']}/rest/2.0/ocr/v1/idcard", params, header)

	        if !result.has_key?("error_code")
	          return {:code => 20001, :data => result.as_json()}
	        else
	          return {:code => result['error_code'], :message => result['error_msg']}
	        end
				end
      end

			desc "银行卡识别"
      params do
				requires :access_token, type: String, desc: 'Access Token'
				optional :image, type: File, desc: '照片文件'
				optional :image_url, type: String, desc: '照片URL'
      end
			post :backcard do
				image = params[:image]
				image_url = params[:image_url]

				if image.blank? && image_url.blank?
					return {:code => 20002, :message => "银行卡照片文件或照片URL至少上传一种！"}
				else
					access_token = params[:access_token]
					# 25.522d32555f292c43d9789ec375a1b1ba.315360000.1854595288.282335-14387235
					if !image_url.blank?
						tempfile = open(image_url)
					end

					if !image.blank?
						tempfile = image.tempfile
					end

					image_base64 = Base64.encode64(File.read(tempfile))
					tempfile.close

					header = {
						"Content-Type" => "application/x-www-form-urlencoded"
					}
					params = {
						:access_token => access_token,
						:image => image_base64
					}
					result = Utils::Helper::post("#{ENV['BAIDU_HTTP_URL']}/rest/2.0/ocr/v1/bankcard", params, header)

	        if !result.has_key?("error_code")
	          return {:code => 20001, :data => result.as_json()}
	        else
	          return {:code => result['error_code'], :message => result['error_msg']}
	        end
				end
			end

			desc "驾驶证识别"
      params do
				requires :access_token, type: String, desc: 'Access Token'
				optional :image, type: File, desc: '照片文件'
				optional :image_url, type: String, desc: '照片URL'
				optional :detect_direction, type: Boolean, desc: '是否检测图像朝向'
				optional :unified_valid_period, type: Boolean, desc: '是否归一化格式输出'
      end
			post :driving_license do
				image = params[:image]
				image_url = params[:image_url]

				if image.blank? && image_url.blank?
					return {:code => 20002, :message => "驾驶证照片文件或照片URL至少上传一种！"}
				else
					access_token = params[:access_token]
					# 25.522d32555f292c43d9789ec375a1b1ba.315360000.1854595288.282335-14387235
					detect_direction = params[:detect_direction]
					unified_valid_period = params[:unified_valid_period]
					if !image_url.blank?
						tempfile = open(image_url)
					end

					if !image.blank?
						tempfile = image.tempfile
					end

					image_base64 = Base64.encode64(File.read(tempfile))
					tempfile.close

					header = {
						"Content-Type" => "application/x-www-form-urlencoded"
					}
					params = {
						:access_token => access_token,
						:image => image_base64,
						:detect_direction => detect_direction,
						:unified_valid_period => unified_valid_period
					}
					result = Utils::Helper::post("#{ENV['BAIDU_HTTP_URL']}/rest/2.0/ocr/v1/driving_license", params, header)

	        if !result.has_key?("error_code")
	          return {:code => 20001, :data => result.as_json()}
	        else
	          return {:code => result['error_code'], :message => result['error_msg']}
	        end
				end
			end

			desc "行驶证识别"
      params do
				requires :access_token, type: String, desc: 'Access Token'
				optional :image, type: File, desc: '照片文件'
				optional :image_url, type: String, desc: '照片URL'
				optional :detect_direction, type: Boolean, desc: '是否检测图像朝向'
				optional :accuracy, type: String, desc: '服务类型'
      end
			post :vehicle_license do
				image = params[:image]
				image_url = params[:image_url]

				if image.blank? && image_url.blank?
					return {:code => 20002, :message => "行驶证照片文件或照片URL至少上传一种！"}
				else
					access_token = params[:access_token]
					# 25.522d32555f292c43d9789ec375a1b1ba.315360000.1854595288.282335-14387235
					detect_direction = params[:detect_direction]
					accuracy = params[:accuracy]
					if !image_url.blank?
						tempfile = open(image_url)
					end

					if !image.blank?
						tempfile = image.tempfile
					end

					image_base64 = Base64.encode64(File.read(tempfile))
					tempfile.close

					header = {
						"Content-Type" => "application/x-www-form-urlencoded"
					}
					params = {
						:access_token => access_token,
						:image => image_base64,
						:detect_direction => detect_direction,
						:accuracy => accuracy
					}
					result = Utils::Helper::post("#{ENV['BAIDU_HTTP_URL']}/rest/2.0/ocr/v1/vehicle_license", params, header)

	        if !result.has_key?("error_code")
	          return {:code => 20001, :data => result.as_json()}
	        else
	          return {:code => result['error_code'], :message => result['error_msg']}
	        end
				end
			end

			desc "车牌识别"
      params do
				requires :access_token, type: String, desc: 'Access Token'
				optional :image, type: File, desc: '照片文件'
				optional :image_url, type: String, desc: '照片URL'
				optional :multi_detect, type: Boolean, desc: '是否检测多张车牌'
      end
			post :license_plate do
				image = params[:image]
				image_url = params[:image_url]

				if image.blank? && image_url.blank?
					return {:code => 20002, :message => "车牌照片文件或照片URL至少上传一种！"}
				else
					access_token = params[:access_token]
					# 25.522d32555f292c43d9789ec375a1b1ba.315360000.1854595288.282335-14387235
					multi_detect = params[:multi_detect]
					if !image_url.blank?
						tempfile = open(image_url)
					end

					if !image.blank?
						tempfile = image.tempfile
					end

					image_base64 = Base64.encode64(File.read(tempfile))
					tempfile.close

					header = {
						"Content-Type" => "application/x-www-form-urlencoded"
					}
					params = {
						:access_token => access_token,
						:image => image_base64,
						:multi_detect => multi_detect
					}
					result = Utils::Helper::post("#{ENV['BAIDU_HTTP_URL']}/rest/2.0/ocr/v1/license_plate", params, header)

	        if !result.has_key?("error_code")
	          return {:code => 20001, :data => result.as_json()}
	        else
	          return {:code => result['error_code'], :message => result['error_msg']}
	        end
				end
			end

			desc "营业执照识别"
      params do
				requires :access_token, type: String, desc: 'Access Token'
				optional :image, type: File, desc: '照片文件'
				optional :image_url, type: String, desc: '照片URL'
				optional :detect_direction, type: Boolean, desc: '是否检测图像朝向'
				optional :accuracy, type: String, desc: '服务类型'
      end
			post :business_license do
				image = params[:image]
				image_url = params[:image_url]

				if image.blank? && image_url.blank?
					return {:code => 20002, :message => "营业执照照片文件或照片URL至少上传一种！"}
				else
					access_token = params[:access_token]
					# 25.522d32555f292c43d9789ec375a1b1ba.315360000.1854595288.282335-14387235
					detect_direction = params[:detect_direction]
					accuracy = params[:accuracy]
					if !image_url.blank?
						tempfile = open(image_url)
					end

					if !image.blank?
						tempfile = image.tempfile
					end

					image_base64 = Base64.encode64(File.read(tempfile))
					tempfile.close

					header = {
						"Content-Type" => "application/x-www-form-urlencoded"
					}
					params = {
						:access_token => access_token,
						:image => image_base64,
						:detect_direction => detect_direction,
						:accuracy => accuracy
					}
					result = Utils::Helper::post("#{ENV['BAIDU_HTTP_URL']}/rest/2.0/ocr/v1/business_license", params, header)

	        if !result.has_key?("error_code")
	          return {:code => 20001, :data => result.as_json()}
	        else
	          return {:code => result['error_code'], :message => result['error_msg']}
	        end
				end
			end

			desc "护照识别"
      params do
				requires :access_token, type: String, desc: 'Access Token'
				optional :image, type: File, desc: '照片文件'
				optional :image_url, type: String, desc: '照片URL'
      end
			post :passport do
				image = params[:image]
				image_url = params[:image_url]

				if image.blank? && image_url.blank?
					return {:code => 20002, :message => "护照照片文件或照片URL至少上传一种！"}
				else
					access_token = params[:access_token]
					# 25.522d32555f292c43d9789ec375a1b1ba.315360000.1854595288.282335-14387235
					if !image_url.blank?
						tempfile = open(image_url)
					end

					if !image.blank?
						tempfile = image.tempfile
					end

					image_base64 = Base64.encode64(File.read(tempfile))
					tempfile.close

					header = {
						"Content-Type" => "application/x-www-form-urlencoded"
					}
					params = {
						:access_token => access_token,
						:image => image_base64
					}
					result = Utils::Helper::post("#{ENV['BAIDU_HTTP_URL']}/rest/2.0/ocr/v1/passport", params, header)

	        if !result.has_key?("error_code")
	          return {:code => 20001, :data => result.as_json()}
	        else
	          return {:code => result['error_code'], :message => result['error_msg']}
	        end
				end
			end

			desc "名片识别"
      params do
				requires :access_token, type: String, desc: 'Access Token'
				optional :image, type: File, desc: '照片文件'
				optional :image_url, type: String, desc: '照片URL'
      end
			post :business_card do
				image = params[:image]
				image_url = params[:image_url]

				if image.blank? && image_url.blank?
					return {:code => 20002, :message => "名片照片文件或照片URL至少上传一种！"}
				else
					access_token = params[:access_token]
					# 25.522d32555f292c43d9789ec375a1b1ba.315360000.1854595288.282335-14387235
					if !image_url.blank?
						tempfile = open(image_url)
					end

					if !image.blank?
						tempfile = image.tempfile
					end

					image_base64 = Base64.encode64(File.read(tempfile))
					tempfile.close

					header = {
						"Content-Type" => "application/x-www-form-urlencoded"
					}
					params = {
						:access_token => access_token,
						:image => image_base64
					}
					result = Utils::Helper::post("#{ENV['BAIDU_HTTP_URL']}/rest/2.0/ocr/v1/business_card", params, header)

	        if !result.has_key?("error_code")
	          return {:code => 20001, :data => result.as_json()}
	        else
	          return {:code => result['error_code'], :message => result['error_msg']}
	        end
				end
			end

			desc "表格文字识别(异步—请求接口)"
      params do
				requires :access_token, type: String, desc: 'Access Token'
				optional :image, type: File, desc: '照片文件'
				optional :image_url, type: String, desc: '照片URL'
      end
			post :request do
				image = params[:image]
				image_url = params[:image_url]

				if image.blank? && image_url.blank?
					return {:code => 20002, :message => "名片照片文件或照片URL至少上传一种！"}
				else
					access_token = params[:access_token]
					# 25.522d32555f292c43d9789ec375a1b1ba.315360000.1854595288.282335-14387235
					if !image_url.blank?
						tempfile = open(image_url)
					end

					if !image.blank?
						tempfile = image.tempfile
					end

					image_base64 = Base64.encode64(File.read(tempfile))
					tempfile.close

					header = {
						"Content-Type" => "application/x-www-form-urlencoded"
					}
					params = {
						:access_token => access_token,
						:image => image_base64
					}
					result = Utils::Helper::post("#{ENV['BAIDU_HTTP_URL']}/rest/2.0/solution/v1/form_ocr/request", params, header)

	        if !result.has_key?("error_code")
	          return {:code => 20001, :data => result.as_json()}
	        else
	          return {:code => result['error_code'], :message => result['error_msg']}
	        end
				end
			end

			desc "表格文字识别(异步—获取结果接口)"
      params do
				requires :access_token, type: String, desc: 'Access Token'
				requires :request_id, type: String, desc: '发送表格文字识别请求时返回的request id'
				optional :result_type, type: String, desc: '期望获取结果的类型'
      end
			post :get_request_result do
				request_id = params[:request_id]
				result_type = params[:result_type]
				access_token = params[:access_token]
				# 25.522d32555f292c43d9789ec375a1b1ba.315360000.1854595288.282335-14387235

				header = {
					"Content-Type" => "application/x-www-form-urlencoded"
				}
				params = {
					:access_token => access_token,
					:result_type => result_type,
					:request_id => request_id
				}
				result = Utils::Helper::post("#{ENV['BAIDU_HTTP_URL']}/rest/2.0/solution/v1/form_ocr/get_request_result", params, header)

        if !result.has_key?("error_code")
          return {:code => 20001, :data => result.as_json()}
        else
          return {:code => result['error_code'], :message => result['error_msg']}
        end
			end

			desc "表格文字识别(同步接口)"
      params do
				requires :access_token, type: String, desc: 'Access Token'
				optional :image, type: File, desc: '照片文件'
				optional :image_url, type: String, desc: '照片URL'
      end
			post :form do
				image = params[:image]
				image_url = params[:image_url]

				if image.blank? && image_url.blank?
					return {:code => 20002, :message => "名片照片文件或照片URL至少上传一种！"}
				else
					access_token = params[:access_token]
					# 25.522d32555f292c43d9789ec375a1b1ba.315360000.1854595288.282335-14387235
					if !image_url.blank?
						tempfile = open(image_url)
					end

					if !image.blank?
						tempfile = image.tempfile
					end

					image_base64 = Base64.encode64(File.read(tempfile))
					tempfile.close

					header = {
						"Content-Type" => "application/x-www-form-urlencoded"
					}
					params = {
						:access_token => access_token,
						:image => image_base64
					}
					result = Utils::Helper::post("#{ENV['BAIDU_HTTP_URL']}/rest/2.0/ocr/v1/form", params, header)

	        if !result.has_key?("error_code")
	          return {:code => 20001, :data => result.as_json()}
	        else
	          return {:code => result['error_code'], :message => result['error_msg']}
	        end
				end
			end

			desc "通用票据识别"
      params do
				requires :access_token, type: String, desc: 'Access Token'
				optional :image, type: File, desc: '照片文件'
				optional :image_url, type: String, desc: '照片URL'
				optional :detect_direction, type: Boolean, desc: '是否检测图像朝向'
				optional :probability, type: Boolean, desc: '是否返回识别结果中每一行的置信度'
				optional :accuracy, type: String, desc: '服务类型'
				optional :recognize_granularity, type: String, desc: '服务类型'
      end
			post :receipt do
				image = params[:image]
				image_url = params[:image_url]

				if image.blank? && image_url.blank?
					return {:code => 20002, :message => "通用文字照片文件或照片URL至少上传一种！"}
				else
					access_token = params[:access_token]
					# 25.522d32555f292c43d9789ec375a1b1ba.315360000.1854595288.282335-14387235
					detect_direction = params[:detect_direction]
					probability = params[:probability]
					accuracy = params[:accuracy]
					recognize_granularity = params[:recognize_granularity]

					if !image_url.blank?
						tempfile = open(image_url)
					end

					if !image.blank?
						tempfile = image.tempfile
					end

					image_base64 = Base64.encode64(File.read(tempfile))
					tempfile.close

					header = {
						"Content-Type" => "application/x-www-form-urlencoded"
					}
	        params = {
						:access_token => access_token,
	          :detect_direction => detect_direction,
	          :probability => probability,
						:accuracy => accuracy,
						:recognize_granularity => recognize_granularity,
						:image => image_base64
	        }
	        result = Utils::Helper::post("#{ENV['BAIDU_HTTP_URL']}/rest/2.0/ocr/v1/receipt", params, header)

	        if !result.has_key?("error_code")
	          return {:code => 20001, :data => result.as_json()}
	        else
	          return {:code => result['error_code'], :message => result['error_msg']}
	        end
				end
			end

			desc "增值税发票识别"
      params do
				requires :access_token, type: String, desc: 'Access Token'
				optional :image, type: File, desc: '照片文件'
				optional :image_url, type: String, desc: '照片URL'
				optional :accuracy, type: String, desc: '服务类型'
      end
			post :vat_invoice do
				image = params[:image]
				image_url = params[:image_url]

				if image.blank? && image_url.blank?
					return {:code => 20002, :message => "增值税发票照片文件或照片URL至少上传一种！"}
				else
					access_token = params[:access_token]
					# 25.522d32555f292c43d9789ec375a1b1ba.315360000.1854595288.282335-14387235
					accuracy = params[:accuracy]

					if !image_url.blank?
						tempfile = open(image_url)
					end

					if !image.blank?
						tempfile = image.tempfile
					end

					image_base64 = Base64.encode64(File.read(tempfile))
					tempfile.close

					header = {
						"Content-Type" => "application/x-www-form-urlencoded"
					}
	        params = {
						:access_token => access_token,
						:accuracy => accuracy,
						:image => image_base64
	        }
	        result = Utils::Helper::post("#{ENV['BAIDU_HTTP_URL']}/rest/2.0/ocr/v1/vat_invoice", params, header)

	        if !result.has_key?("error_code")
	          return {:code => 20001, :data => result.as_json()}
	        else
	          return {:code => result['error_code'], :message => result['error_msg']}
	        end
				end
			end

			desc "火车票识别"
      params do
				requires :access_token, type: String, desc: 'Access Token'
				optional :image, type: File, desc: '照片文件'
				optional :image_url, type: String, desc: '照片URL'
      end
			post :train_ticket do
				image = params[:image]
				image_url = params[:image_url]

				if image.blank? && image_url.blank?
					return {:code => 20002, :message => "火车票照片文件或照片URL至少上传一种！"}
				else
					access_token = params[:access_token]
					# 25.522d32555f292c43d9789ec375a1b1ba.315360000.1854595288.282335-14387235
					if !image_url.blank?
						tempfile = open(image_url)
					end

					if !image.blank?
						tempfile = image.tempfile
					end

					image_base64 = Base64.encode64(File.read(tempfile))
					tempfile.close

					header = {
						"Content-Type" => "application/x-www-form-urlencoded"
					}
					params = {
						:access_token => access_token,
						:image => image_base64
					}
					result = Utils::Helper::post("#{ENV['BAIDU_HTTP_URL']}/rest/2.0/ocr/v1/train_ticket", params, header)

	        if !result.has_key?("error_code")
	          return {:code => 20001, :data => result.as_json()}
	        else
	          return {:code => result['error_code'], :message => result['error_msg']}
	        end
				end
			end

			desc "出租车票识别"
      params do
				requires :access_token, type: String, desc: 'Access Token'
				optional :image, type: File, desc: '照片文件'
				optional :image_url, type: String, desc: '照片URL'
			end
			post :taxi_receipt do
				image = params[:image]
				image_url = params[:image_url]

				if image.blank? && image_url.blank?
					return {:code => 20002, :message => "出租车票照片文件或照片URL至少上传一种！"}
				else
					access_token = params[:access_token]
					# 25.522d32555f292c43d9789ec375a1b1ba.315360000.1854595288.282335-14387235
					if !image_url.blank?
						tempfile = open(image_url)
					end

					if !image.blank?
						tempfile = image.tempfile
					end

					image_base64 = Base64.encode64(File.read(tempfile))
					tempfile.close

					header = {
						"Content-Type" => "application/x-www-form-urlencoded"
					}
					params = {
						:access_token => access_token,
						:image => image_base64
					}
					result = Utils::Helper::post("#{ENV['BAIDU_HTTP_URL']}/rest/2.0/ocr/v1/taxi_receipt", params, header)

	        if !result.has_key?("error_code")
	          return {:code => 20001, :data => result.as_json()}
	        else
	          return {:code => result['error_code'], :message => result['error_msg']}
	        end
				end
			end

			desc "数字识别"
      params do
				requires :access_token, type: String, desc: 'Access Token'
				optional :image, type: File, desc: '照片文件'
				optional :image_url, type: String, desc: '照片URL'
				optional :recognize_granularity, type: String, desc: '是否定位单字符位置'
				optional :detect_direction, type: Boolean, desc: '是否检测图像朝向'
      end
			post :numbers do
				image = params[:image]
				image_url = params[:image_url]

				if image.blank? && image_url.blank?
					return {:code => 20002, :message => "彩票照片文件或照片URL至少上传一种！"}
				else
					access_token = params[:access_token]
					# 25.522d32555f292c43d9789ec375a1b1ba.315360000.1854595288.282335-14387235
					recognize_granularity = params[:recognize_granularity]
					detect_direction = params[:detect_direction]

					if !image_url.blank?
						tempfile = open(image_url)
					end

					if !image.blank?
						tempfile = image.tempfile
					end

					image_base64 = Base64.encode64(File.read(tempfile))
					tempfile.close

					header = {
						"Content-Type" => "application/x-www-form-urlencoded"
					}
	        params = {
						:access_token => access_token,
	          :recognize_granularity => recognize_granularity,
						:detect_direction => detect_direction,
						:image => image_base64
	        }
	        result = Utils::Helper::post("#{ENV['BAIDU_HTTP_URL']}/rest/2.0/ocr/v1/numbers", params, header)

	        if !result.has_key?("error_code")
	          return {:code => 20001, :data => result.as_json()}
	        else
	          return {:code => result['error_code'], :message => result['error_msg']}
	        end
				end
			end

			desc "彩票识别"
      params do
				requires :access_token, type: String, desc: 'Access Token'
				optional :image, type: File, desc: '照片文件'
				optional :image_url, type: String, desc: '照片URL'
				optional :recognize_granularity, type: String, desc: '是否定位单字符位置'
      end
			post :lottery do
				image = params[:image]
				image_url = params[:image_url]

				if image.blank? && image_url.blank?
					return {:code => 20002, :message => "彩票照片文件或照片URL至少上传一种！"}
				else
					access_token = params[:access_token]
					# 25.522d32555f292c43d9789ec375a1b1ba.315360000.1854595288.282335-14387235
					recognize_granularity = params[:recognize_granularity]

					if !image_url.blank?
						tempfile = open(image_url)
					end

					if !image.blank?
						tempfile = image.tempfile
					end

					image_base64 = Base64.encode64(File.read(tempfile))
					tempfile.close

					header = {
						"Content-Type" => "application/x-www-form-urlencoded"
					}
	        params = {
						:access_token => access_token,
	          :recognize_granularity => recognize_granularity,
						:image => image_base64
	        }
	        result = Utils::Helper::post("#{ENV['BAIDU_HTTP_URL']}/rest/2.0/ocr/v1/lottery", params, header)

	        if !result.has_key?("error_code")
	          return {:code => 20001, :data => result.as_json()}
	        else
	          return {:code => result['error_code'], :message => result['error_msg']}
	        end
				end
			end

    end
  end
end
