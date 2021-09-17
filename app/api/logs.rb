class Logs < Grape::API
	resource :logs do

		get do
			log = Log.all()
		end

		desc "ユーザがどこのviewにアクセスしたか"
		params do
	    	optional :user_id, type: Integer, desc: 'ユーザID'
	    	optional :view, type: String, desc: 'viewネーム'
	    	optional :state, type: String, desc: '状態'
	    	optional :version, type: Float, desc: 'version'
	    end
	    post do
	    	log = Log.new(
	    		user_id: params[:user_id],
	    		view: params[:view],
	    		state: params[:state],
	    		version: params[:version],
	    	)
	    	log.save
	    end
	end
end