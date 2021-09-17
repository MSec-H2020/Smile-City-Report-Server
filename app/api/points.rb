class Points < Grape::API
  resource :points do
    desc "ポイント情報を取得"
    params do
      optional :id, type: Integer, desc: "pointのID"
    end
    get '/', jbuilder: 'api' do
      points = Point.all
      if params[:id]
        points = points.where(id: params[:id])
      end
      @points = points
    end

    desc "ポイント情報を登録"
    params do
      requires :point, type: Integer, desc: "point"
      requires :reason, type: String, desc: "point理由"
    end
    post '/', jbuilder: 'api' do
      point = Point.new(
        point: params[:point],
        reason: params[:reason]
      )
      point.save
      @points = Point.where(id: point.id)
    end

  end
end