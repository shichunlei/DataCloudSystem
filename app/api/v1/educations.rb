module V1
	class Educations < Grape::API
		resource :educations do

			desc "唐诗类别"
			params do
			end
			get :tangshi_types do
				list = Tangshi.order(:id).as_json(:only => [:mtype])
				arr = []
				list.each do |item|
					arr.push(item["mtype"])
				end
				return {"code" => 20001, "message" => "请求成功", :result => arr.uniq}
			end

			desc "唐诗作者"
			params do
			end
			get :tangshi_author do
				list = Tangshi.order(:id).as_json(:only => [:author])
				arr = []
				list.each do |item|
					arr.push(item["author"])
				end
				return {"code" => 20001, "message" => "请求成功", :result => arr.uniq}
			end

      desc "根据类型得到唐诗列表"
			params do
				requires :mtype, type: String, desc: '唐诗类别'
			end
			get :tangshi_list do
				list = Tangshi.where(mtype:params[:mtype]).order(:id)
				return {"code" => 20001, "message" => "请求成功", :result => list.as_json(:only => [:id, :name, :author])}
			end

			desc "根据作者得到唐诗列表"
			params do
				requires :author, type: String, desc: '作者'
			end
			get :tangshi_author_list do
				list = Tangshi.where(author:params[:author]).order(:id)
				return {"code" => 20001, "message" => "请求成功", :result => list.as_json(:only => [:id, :name, :author, :mtype])}
			end

			desc "唐诗详情"
			params do
				requires :id, type: Integer, desc: 'ID'
			end
			get :tangshi_details do
				object = Tangshi.find_by(id:params[:id])
				return {"code" => 20001, "message" => "请求成功", :result => object.as_json(:only => [:id, :name, :author, :mtype, :content, :explanation, :appreciation])}
			end

			desc "宋词类别"
			params do
			end
			get :songci_types do
				list = Songci.order(:id).as_json(:only => [:mtype])
				arr = []
				list.each do |item|
					arr.push(item["mtype"])
				end
				return {"code" => 20001, "message" => "请求成功", :result => arr.uniq}
			end

			desc "宋词作者"
			params do
			end
			get :songci_author do
				list = Songci.order(:id).as_json(:only => [:author])
				arr = []
				list.each do |item|
					arr.push(item["author"])
				end
				return {"code" => 20001, "message" => "请求成功", :result => arr.uniq}
			end

      desc "根据类型得到宋词列表"
			params do
				requires :mtype, type: String, desc: '宋词类别'
			end
			get :songci_list do
				list = Songci.where(mtype:params[:mtype]).order(:id)
				return {"code" => 20001, "message" => "请求成功", :result => list.as_json(:only => [:id, :name, :author])}
			end

			desc "根据作者得到宋词列表"
			params do
				requires :author, type: String, desc: '宋词作者'
			end
			get :songci_author_list do
				list = Songci.where(author:params[:author]).order(:id)
				return {"code" => 20001, "message" => "请求成功", :result => list.as_json(:only => [:id, :name, :author, :mtype])}
			end

			desc "宋词详情"
			params do
				requires :id, type: Integer, desc: 'ID'
			end
			get :songci_details do
				object = Songci.find_by(id:params[:id])
				return {"code" => 20001, "message" => "请求成功", :result => object.as_json(:only => [:id, :name, :author, :mtype, :content, :explanation, :appreciation])}
			end

			desc "元曲作者"
			params do
			end
			get :yuanqu_author do
				list = Yuanqu.order(:id).as_json(:only => [:author])
				arr = []
				list.each do |item|
					arr.push(item["author"])
				end
				return {"code" => 20001, "message" => "请求成功", :result => arr.uniq}
			end

			desc "元曲列表"
			params do
				requires :author, type: String, desc: '作者'
			end
			get :yuanqu_list do
				list = Yuanqu.where(author:params[:author]).order(:id)
				return {"code" => 20001, "message" => "请求成功", :result => list.as_json(:only => [:id, :name, :author])}
			end

			desc "元曲详情"
			params do
				requires :id, type: Integer, desc: 'ID'
			end
			get :yuanqu_details do
				object = Yuanqu.find_by(id:params[:id])
				return {"code" => 20001, "message" => "请求成功", :result => object.as_json(:only => [:id, :name, :author, :content, :explanation, :appreciation])}
			end

			desc "三字经"
			params do
			end
			get :sanzijing do
				object = Book.find_by(id:1)
				return {"code" => 20001, "message" => "请求成功", :result => object.as_json()}
			end

			desc "弟子规章节"
			params do
			end
			get :dizigui do
				list = Book.where(name:"弟子规").order(:id)
				return {"code" => 20001, "message" => "请求成功", :result => list.as_json()}
			end

			desc "弟子规详情"
			params do
				requires :id, type: Integer, desc: 'ID'
			end
			get :dizigui_detail do
				id = params[:id]
				object = Book.find_by(id:id)
				return {"code" => 20001, "message" => "请求成功", :result => object.as_json()}
			end

			desc "千字文"
			params do
			end
			get :qianziwen do
				object = Book.find_by(id:3)
				return {"code" => 20001, "message" => "请求成功", :result => object.as_json()}
			end

			desc "百家姓列表"
			params do
			end
			get :baijiaxing do
				object = Book.find_by(id:2)
				return {"code" => 20001, "message" => "请求成功", :result => object.as_json()}
			end

			desc "百家姓介绍"
			params do
				requires :id, type: Integer, desc: 'ID'
			end
			get :baijiaxing_detail do
				id = params[:id]
				object = Baijiaxing.find_by(id:id)
				return {"code" => 20001, "message" => "请求成功", :result => object.as_json(:only => [:id, :source, :name, :celebrity, :distributing])}
			end

			desc "论语篇章"
			params do
			end
			get :lunyu_chapter do
				list = Lunyu.order(:id).as_json(:only => [:chapter])
				arr = []
				list.each do |item|
					arr.push(item["chapter"])
				end
				chapters = []
				chapternames = arr.uniq
				chapternames.each do |item|
		      chapter = {}
		      chapter.store("chaptername", item)
		      object = Lunyu.where(chapter:item).order(:id).as_json(:only => [:id, :name])
		      chapter.store("chapter", object)
		      chapters.push(chapter)
		    end
				return {"code" => 20001, "message" => "请求成功", :result => chapters.as_json()}
			end

			desc "论语详情"
			params do
				requires :id, type: Integer, desc: 'ID'
			end
			get :lunyu_detail do
				object = Lunyu.find_by(id:params[:id])
				return {"code" => 20001, "message" => "请求成功", :result => object.as_json(:only => [:id, :name, :content, :chapter, :commentary, :translation, :appreciation])}
			end

			desc "论语十则（随机）"
			params do
			end
			get :lunyu_list do
				id_arr = (1..511).to_a
				ids = id_arr.sample(10)
				list = Lunyu.where(:id => ids)
				return {"code" => 20001, "message" => "请求成功", :result => list.as_json(:only => [:id, :name, :chapter])}
			end

			desc "诗经篇章"
			params do
			end
			get :shijing_chapter do
				list = Shijing.order(:id).as_json(:only => [:chapter])
				arr = []
				list.each do |item|
					arr.push(item["chapter"])
				end
				chapters = []
				chapternames = arr.uniq
				chapternames.each do |item|
		      chapter = {}
		      chapter.store("chaptername", item)
		      object = Shijing.where(chapter:item).order(:id).as_json(:only => [:id, :name])
		      chapter.store("chapter", object)
		      chapters.push(chapter)
		    end
				return {"code" => 20001, "message" => "请求成功", :result => chapters.as_json()}
			end

			desc "诗经详情"
			params do
				requires :id, type: Integer, desc: 'ID'
			end
			get :shijing_detail do
				object = Shijing.find_by(id:params[:id])
				return {"code" => 20001, "message" => "请求成功", :result => object.as_json(:only => [:id, :name, :content, :chapter, :commentary, :translation, :appreciation])}
			end

    end
  end
end
