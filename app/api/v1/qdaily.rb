module V1
	class Qdaily < Grape::API

		include Utils

		resource :qdaily do

			desc "手机号码登录"
      params do
        requires :phone, type: String, desc: '手机号'
        requires :password, type: Integer, desc: '密码'
      end
      post :login_phone do
        phone = params[:phone]
        password = params[:password]

        params = {
					:password => password,
					:phone => phone,
					:remember_me => 1
				}
        result = Utils::Helper::post("#{ENV['QDAILY_BASE_URL']}users/phone_sign_in", params)

        if result['meta']['status'] == 200
          return {:code => 0, :message => result['meta']['msg'], :data => result.as_json()}
        else
          return {:code => 1, :message => result['meta']['msg']}
        end
      end

			desc "邮箱登录"
      params do
        requires :email, type: String, desc: '手机号'
        requires :password, type: Integer, desc: '密码'
      end
      post :login do
        email = params[:email]
        password = params[:password]

        params = {
					:password => password,
					:email => email,
					:remember_me => 1
				}
        result = Utils::Helper::post("#{ENV['QDAILY_BASE_URL']}users/sign_in", params)

        if result['meta']['status'] == 200
          return {:code => 0, :message => result['meta']['msg'], :data => result.as_json()}
        else
          return {:code => 1, :message => result['meta']['msg']}
        end
      end

      desc "首页"
      params do
        requires :last_key, type: String, desc: 'lastKey'
      end
      get :home_data do
        lastKey = params[:last_key]

        result = Utils::Helper::get("#{ENV['QDAILY_BASE_URL']}app3/homes/index_v2/#{lastKey}.json")

        if result['meta']['status'] == 200
          result['response'].delete("banners_ad")
          result['response'].delete('feeds_ad')
          result['response'].delete('columns_ad')
					result['response'].delete('featured_article')
          return {:code => 0, :message => result['meta']['msg'], :data => result['response'].as_json()}
        else
          return {:code => 1, :message => result['meta']['msg']}
        end
      end

			desc "获取分类"
      params do
      end
      get :categories do
        result = Utils::Helper::get("#{ENV['QDAILY_BASE_URL']}app3/homes/left_sidebar.json")

        if result['meta']['status'] == 200
          return {:code => 0, :message => result['meta']['msg'], :data => result['response'].as_json()}
        else
          return {:code => 1, :message => result['meta']['msg']}
        end
      end

      desc "获取某分类下的新闻"
      params do
        requires :last_key, type: String, desc: 'lastKey'
        requires :tag_id, type: Integer, desc: 'tagId'
      end
      get :news_by_category do
        lastKey = params[:last_key]
        tagId = params[:tag_id]

        result = Utils::Helper::get("#{ENV['QDAILY_BASE_URL']}app3/categories/index/#{tagId}/#{lastKey}.json")

        if result['meta']['status'] == 200
          result['response'].delete("banners_ad")
          result['response'].delete('feeds_ad')
          result['response'].delete('columns_ad')
          return {:code => 0, :message => result['meta']['msg'], :data => result['response'].as_json()}
        else
          return {:code => 1, :message => result['meta']['msg']}
        end
      end

			desc "新闻详情"
      params do
        requires :id, type: Integer, desc: 'tagId'
      end
      get :articles_details do
        id = params[:id]

        info = Utils::Helper::get("#{ENV['QDAILY_BASE_URL']}app3/articles/info/#{id}.json")

				details = Utils::Helper::get("#{ENV['QDAILY_BASE_URL']}app3/articles/detail/#{id}.json")

        if info['meta']['status'] == 200
					if details['meta']['status'] == 200
						info['response']['post'].store("body", details['response']['article']['body'])
						info['response']['post'].store("js", details['response']['article']['js'])
						info['response']['post'].store("css", details['response']['article']['css'])
						info['response']['post'].store("info_image", details['response']['article']['image'])

						return {:code => 0, :message => info['meta']['msg'], :data => info['response'].as_json()}
					end
        else
          return {:code => 1, :message => info['meta']['msg']}
        end
      end

      desc "获取文章/新闻评论"
      params do
        requires :last_key, type: String, desc: 'lastKey'
        requires :id, type: Integer, desc: 'Id'
        requires :datatype, type: String, desc: 'Type'
      end
      get :comments do
        lastKey = params[:last_key]
        id = params[:id]
        datatype = params[:datatype]

        result = Utils::Helper::get("#{ENV['QDAILY_BASE_URL']}app3/comments/index/#{datatype}/#{id}/#{lastKey}.json")

        if result['meta']['status'] == 200
          result['response'].delete("top_comments")
          return {:code => 0, :message => result['meta']['msg'], :data => result['response'].as_json()}
        else
          return {:code => 1, :message => result['meta']['msg']}
        end
      end

			desc "发表评论"
      params do
        requires :parent_id, type: Integer, desc: '父ID'
        requires :id, type: Integer, desc: 'Id'
        requires :comment_type, type: String, desc: 'Type'
				requires :content, type: String, desc: '评论内容'
      end
      get :create_comment do
        parent_id = params[:parent_id]
        id = params[:id]
        comment_type = params[:comment_type]
				content = params[:content]

        params = {
					:parent_id => parent_id,
					:id => id,
					:comment_type => comment_type,
					:content => content
				}
        result = Utils::Helper::post("#{ENV['QDAILY_BASE_URL']}app3/comments/create_comment", params)

        if result['meta']['status'] == 200
          return {:code => 0, :message => result['meta']['msg'], :data => result['response'].as_json()}
        else
          return {:code => 1, :message => result['meta']['msg']}
        end
      end

			desc "对文章/评论点赞或取消点赞"
      params do
        requires :genre, type: Integer, desc: '点赞动作' # 点赞：1，取消点赞：2
        requires :id, type: Integer, desc: 'Id'
        requires :praise_type, type: String, desc: 'Type' # 评论：comment，新闻：article
      end
      get :create_praise do
        genre = params[:genre]
        id = params[:id]
        praise_type = params[:praise_type]

        params = {
					:genre => genre,
					:id => id,
					:praise_type => praise_type
				}
        result = Utils::Helper::post("#{ENV['QDAILY_BASE_URL']}app3/praises/create_praise", params)

        if result['meta']['status'] == 200
          return {:code => 0, :message => result['meta']['msg'], :data => result['response'].as_json()}
        else
          return {:code => 1, :message => result['meta']['msg']}
        end
      end

      desc "栏目列表"
      params do
        requires :last_key, type: String, desc: 'lastKey'
      end
      get :columns do
        lastKey = params[:last_key]

        result = Utils::Helper::get("#{ENV['QDAILY_BASE_URL']}app3/columns/all_columns_index/#{lastKey}.json")

				if result['meta']['status'] == 200
          result['response'].delete("columns_ad")
          return {:code => 0, :message => result['meta']['msg'], :data => result['response'].as_json()}
        else
          return {:code => 1, :message => result['meta']['msg']}
        end
      end

      desc "栏目详情"
      params do
        requires :column_id, type: Integer, desc: 'Id'
      end
      get :column_info do
        column_id = params[:column_id]

        result = Utils::Helper::get("#{ENV['QDAILY_BASE_URL']}app3/columns/info/#{column_id}.json")

        if result['meta']['status'] == 200
					column = result['response']['column']
					column.store('authors', result['response']['authors'])
					column.store('subscribers', result['response']['subscribers'])

					news_result = Utils::Helper::get("#{ENV['QDAILY_BASE_URL']}app3/columns/index/#{column_id}/0.json")

					if news_result['meta']['status'] == 200
						data = {}
						data.store("last_key", news_result['response']['last_key'])
						data.store("has_more", news_result['response']['has_more'])
						data.store("feeds", news_result['response']['feeds'])
						data.store("column", column)
	          return {:code => 0, :message => result['meta']['msg'], :data => data.as_json()}
	        else
	          return {:code => 1, :message => result['meta']['msg']}
	        end
        else
          return {:code => 1, :message => result['meta']['msg']}
        end
      end

      desc "栏目新闻"
      params do
        requires :column_id, type: Integer, desc: 'Id'
        requires :last_key, type: String, desc: 'lastKey'
      end
      get :column_news do
        column_id = params[:column_id]
        lastKey = params[:last_key]

        result = Utils::Helper::get("#{ENV['QDAILY_BASE_URL']}app3/columns/index/#{column_id}/#{lastKey}.json")

        if result['meta']['status'] == 200
          result['response'].delete("top_comments")
          return {:code => 0, :message => result['meta']['msg'], :data => result['response'].as_json()}
        else
          return {:code => 1, :message => result['meta']['msg']}
        end
      end

      desc "好奇心日报研究所"
      params do
        requires :last_key, type: String, desc: 'lastKey'
      end
      get :papers do
        lastKey = params[:last_key]

        result = Utils::Helper::get("#{ENV['QDAILY_BASE_URL']}app3/papers/index/#{lastKey}.json")

        if result['meta']['status'] == 200
          result['response'].delete('feeds_ad')
          return {:code => 0, :message => result['meta']['msg'], :data => result['response'].as_json()}
        else
          return {:code => 1, :message => result['meta']['msg']}
        end
      end

			desc "好奇心日报研究所Topics新闻/文章"
      params do
        requires :last_key, type: String, desc: 'lastKey'
				requires :topic_id, type: String, desc: 'topicId'
      end
      get :paper_topics do
        lastKey = params[:last_key]
				topic_id = params[:topic_id]

        result = Utils::Helper::get("#{ENV['QDAILY_BASE_URL']}app3/paper_topics/index/#{topic_id}/#{lastKey}.json")

        if result['meta']['status'] == 200
          result['response'].delete('feeds_ad')
          return {:code => 0, :message => result['meta']['msg'], :data => result['response'].as_json()}
        else
          return {:code => 1, :message => result['meta']['msg']}
        end
      end

			desc "好奇心日报研究所类型新闻/文章"
      params do
        requires :last_key, type: String, desc: 'lastKey'
				requires :genre, type: String, desc: '类型'
      end
      get :paper_genres do
        lastKey = params[:last_key]
				genre = params[:genre]

        result = Utils::Helper::get("#{ENV['QDAILY_BASE_URL']}app3/paper_genres/index/#{genre}/#{lastKey}.json")

        if result['meta']['status'] == 200
          result['response'].delete('feeds_ad')
          return {:code => 0, :message => result['meta']['msg'], :data => result['response'].as_json()}
        else
          return {:code => 1, :message => result['meta']['msg']}
        end
      end

      desc "好奇心日报研究所详情（我说、投票）"
      params do
        requires :paper_id, type: String, desc: 'paper_id'
      end
      get :paper_info do
        paper_id = params[:paper_id]

        result = Utils::Helper::get("#{ENV['QDAILY_BASE_URL']}app3/papers/detail/#{paper_id}.json")

        if result['meta']['status'] == 200
					# result['response'].delete('options')
          return {:code => 0, :message => result['meta']['msg'], :data => result['response'].as_json()}
        else
          return {:code => 1, :message => result['meta']['msg']}
        end
      end

			desc "投票详情"
      params do
        requires :paper_id, type: String, desc: 'paper_id'
      end
      get :vote_info do
        paper_id = params[:paper_id]

        result = Utils::Helper::get("#{ENV['QDAILY_BASE_URL']}app3/papers/detail/#{paper_id}.json")

        if result['meta']['status'] == 200
					if result['response']["questions"] != nil
						data = {}
						data.store("question", result['response']["questions"][0])
						data.store("type", result['response']["type"])
						data.store("image", result['response']["image"])
						data.store("post", result['response']["post"])
						return {:code => 0, :message => result['meta']['msg'], :data => data.as_json()}
					else
						return {:code => 1, :message => result['meta']['msg']}
					end
        else
          return {:code => 1, :message => result['meta']['msg']}
        end
      end

			desc "投票结果"
      params do
        requires :paper_id, type: String, desc: 'paper_id'
      end
      get :vote_result do
        paper_id = params[:paper_id]

        result = Utils::Helper::get("#{ENV['QDAILY_BASE_URL']}app3/papers/#{paper_id}/vote_result.json")

        if result['meta']['status'] == 200
					result['response'].delete('option')
          return {:code => 0, :message => result['meta']['msg'], :data => result['response'].as_json()}
        else
          return {:code => 1, :message => result['meta']['msg']}
        end
      end

			desc "好奇心日报研究所“我说”的选项"
      params do
        requires :id, type: String, desc: 'id'
				requires :last_key, type: String, desc: 'lastKey'
      end
      get :i_say do
        id = params[:id]
				last_key = params[:last_key]

        result = Utils::Helper::get("#{ENV['QDAILY_BASE_URL']}app3/options/index/#{id}/#{last_key}.json")

        if result['meta']['status'] == 200
          result['response'].delete('my_options')
          return {:code => 0, :message => result['meta']['msg'], :data => result['response'].as_json()}
        else
          return {:code => 1, :message => result['meta']['msg']}
        end
      end

			desc "好奇心日报研究所“42%”详情"
      params do
        requires :id, type: String, desc: 'id'
      end
      get :tots do
        id = params[:id]

        result = Utils::Helper::get("#{ENV['QDAILY_BASE_URL']}app3/paper/tots/#{id}.json")

        if result['meta']['status'] == 200
					data = {}
					data.store("gender_question", result['response']["gender_question"])
					data.store("slide_question", result['response']["slide_question"])
					data.store("questions", result['response']["normal_questions"])
					data.store("post", result['response']["paper"])
          return {:code => 0, :message => result['meta']['msg'], :data => data.as_json()}
          # return {:code => 0, :message => result['meta']['msg'], :data => result['response'].as_json()}
        else
          return {:code => 1, :message => result['meta']['msg']}
        end
      end

			desc "好奇心日报研究所“42%”结果"
      params do
        requires :id, type: String, desc: 'id'
      end
      get :tot_results do
        id = params[:id]

        result = Utils::Helper::get("#{ENV['QDAILY_BASE_URL']}app3/paper/tot_results/#{id}.json")

        if result['meta']['status'] == 200
          return {:code => 0, :message => result['meta']['msg'], :data => result['response'].as_json()}
        else
          return {:code => 1, :message => result['meta']['msg']}
        end
      end

			desc "好奇心日报研究所“你是谁”详情"
      params do
        requires :id, type: String, desc: 'id'
      end
      get :whos do
        id = params[:id]

        result = Utils::Helper::get("#{ENV['QDAILY_BASE_URL']}app3/paper/whos/#{id}.json")

        if result['meta']['status'] == 200
					data = {}
					data.store("questions", result['response']["normal_questions"])
					data.store("post", result['response']["paper"])
          return {:code => 0, :message => result['meta']['msg'], :data => data.as_json()}
        else
          return {:code => 1, :message => result['meta']['msg']}
        end
      end

			desc "好奇心日报研究所“你是谁”结果"
      params do
        requires :id, type: String, desc: 'id'
      end
      get :whos_result do
        id = params[:id]

        result = Utils::Helper::get("#{ENV['QDAILY_BASE_URL']}app3/paper/whos/result/#{id}.json")

        if result['meta']['status'] == 200
          return {:code => 0, :message => result['meta']['msg'], :data => result['response'].as_json()}
        else
          return {:code => 1, :message => result['meta']['msg']}
        end
      end

			desc "好奇心日报研究所“你猜”详情"
      params do
        requires :id, type: String, desc: 'id'
      end
      get :choices do
        id = params[:id]

        result = Utils::Helper::get("#{ENV['QDAILY_BASE_URL']}app3/paper/choices/#{id}.json")

        if result['meta']['status'] == 200
					data = {}
					data.store("questions", result['response']["normal_questions"])
					data.store("post", result['response']["paper"])
          return {:code => 0, :message => result['meta']['msg'], :data => data.as_json()}
        else
          return {:code => 1, :message => result['meta']['msg']}
        end
      end

      desc "搜索"
      params do
        requires :last_key, type: String, desc: 'lastKey'
        requires :keyword, type: String, desc: '关键字'
      end
      get :search do
        lastKey = params[:last_key]
        keyword = params[:keyword]

        result = Utils::Helper::get("#{ENV['QDAILY_BASE_URL']}app3/searches/post_list.json?last_key=#{lastKey}&search=#{keyword}")

        if result['meta']['status'] == 200
          return {:code => 0, :message => result['meta']['msg'], :data => result['response'].as_json()}
        else
          return {:code => 1, :message => result['meta']['msg']}
        end
      end

			desc "搜索(带高亮效果)"
      params do
        requires :last_key, type: String, desc: 'lastKey'
        requires :keyword, type: String, desc: '关键字'
      end
      get :search_highlighting do
        lastKey = params[:last_key]
        keyword = params[:keyword]

        result = Utils::Helper::get("#{ENV['QDAILY_BASE_URL']}app3/searches/post_highlighting_list.json?last_key=#{lastKey}&search=#{keyword}")

				if result['meta']['status'] == 200
					result['response'].delete('authors')
					result['response'].store("feeds", result['response']["searches"])
					result['response'].delete('searches')
          return {:code => 0, :message => result['meta']['msg'], :data => result['response'].as_json()}
        else
          return {:code => 1, :message => result['meta']['msg']}
        end
      end

			desc "搜索（有图）"
      params do
        requires :last_key, type: String, desc: 'lastKey'
        requires :keyword, type: String, desc: '关键字'
      end
      get :search_web do
        lastKey = params[:last_key]
        keyword = params[:keyword]

        result = Utils::Helper::get("http://www.qdaily.com/searches/more_search.json?last_key=#{lastKey}&key=#{keyword}")

        if result['status']
          return {:code => 0, :message => "", :data => result["data"].as_json()}
        else
          return {:code => 1, :message => ""}
        end
      end

    end
  end
end
