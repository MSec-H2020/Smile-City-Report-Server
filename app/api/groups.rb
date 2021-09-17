class Groups < Grape::API
	resource :groups do
		desc "グループ情報取得"
		params do
			optional :id, type: Integer, desc: "group_id"
			optional :group_name, type: String, desc: "group_name"
		end
		get '/', jbuilder: 'api' do
			groups = Group.all
			if params[:id]
				groups = groups.where(id: params[:id])
			end
			if params[:group_name]
				groups = groups.where(group_name: params[:group_name])
			end
			@groups = groups
		end

		desc "グループに属しているユーザ一覧を取得"
		params do
	  	optional :group_id, type: Integer, desc: 'グループID'
		end
		get :users, jbuilder: 'api' do
			user_ids = []
			users = []
	  	usergroups = UserGroup.where(group_id: params[:group_id])
			usergroups.each do |usergroup|
				user_ids.push(usergroup.user_id)
			end
			for i in user_ids
				users.push(User.where(id: i)).flatten!
			end
			@users = users.sort{|a,b| b["created_at"] <=> a["created_at"]}
		end

		desc "グループに所属しているユーザの笑顔一覧を取得する"
		params do
  		optional :group_id, type: Integer, desc: 'グループID'
  	end
  	get :smiles, jbuilder: 'api' do
			user_ids = []
			users = []
			usergroups = UserGroup.where(group_id: params[:group_id])
			usergroups.each do |usergroup|
				user_ids.push(usergroup.user_id)
			end
			for i in user_ids
				users.push(User.where(id: i)).flatten!
			end
  		smile_ids = []
  		smiles = []
  		smilegroups = SmileGroup.where(group_id: params[:group_id])
  		smilegroups.each do |smilegroup|
  			smile_ids.push(smilegroup.smile_id)
  		end
  		for smile_id in smile_ids
				smile = Smile.where(id: smile_id)
	  		smiles.push(smile).flatten!
	  	end
		 	@smiles = smiles.sort{|a,b| b["created_at"] <=> a["created_at"]}
		end

  	desc "新しいグループをつくる"
  	params do
  		requires :group_name, type: String, desc: "グループ名前"
  	end
  	post :create, jbuilder: 'api' do
  		group = Group.new(
  			group_name: params[:group_name]
  		)
  		group.save!
			@groups = Group.where(id: group.id)
			Rails.logger.debug(@groups.inspect)
  	end

		desc "グループを消す"
		params do
			requires :group_id, type: Integer, desc: "groupID"
		end
		delete :delete, jbuilder: 'api' do
			group = Group.find_by(id: params[:group_id])
			group.destroy
			usergroup = UserGroup.where(group_id: params[:group_id])
			usergroup.destroy_all
		end
	end
end
