module V1
	class Recipes < Grape::API
		resource :recipes do

      desc "菜谱分类"
      params do
        requires :appkey, type: String, desc: 'AppKey'
      end
      get :classify do
        list = RecipeClassify.where("recipe_classify_id IS NULL").order(:id)
        return {"code" => 20001, "message" => "请求成功", :result => list.as_json(:only => [:id, :name], :methods => [:sub_classify])}
      end

      desc "根据分类ID得到菜谱"
      params do
        requires :appkey, type: String, desc: 'AppKey'
        requires :classify_id, type: Integer, desc: '分类ID'
      end
      get :list do
        classify_id = params[:classify_id]
        list = Recipe.where(recipe_classify_id:classify_id).order(:id)
        return {"code" => 20001, "message" => "请求成功", :result => list.as_json(:only => [:id, :name, :tag, :pic, :peoplenum, :cookingtime, :preparetime])}
      end

      desc "根据分类ID得到菜谱"
      params do
        requires :appkey, type: String, desc: 'AppKey'
        requires :recipe_id, type: Integer, desc: '菜谱ID'
      end
      get :details do
        recipe_id = params[:recipe_id]
        object = Recipe.find_by(id:recipe_id)
        return {"code" => 20001, "message" => "请求成功", :result => object.as_json(:only => [:id, :name, :tag, :pic, :peoplenum, :cookingtime, :preparetime, :content], :methods => [:process, :material])}
      end
    end
  end
end
