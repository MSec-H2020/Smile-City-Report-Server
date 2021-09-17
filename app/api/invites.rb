include Response

class Invites < Grape::API
  resource :invites do
    desc "アプリリンクにリダイレクトする"
    params do
      requires :id, type: Integer, desc: "invitationのID"
    end
    get '/' do
      invitation = Invitation.where(id: params[:id])
      invitation_code = invitation[0].code
      url_scheme = "sushirepo://invites?code="+invitation_code
      hash = {}
      hash[:result] = true
      hash[:data] = {}
      hash[:data][:url_scheme] = url_scheme
    end

    desc "invitationを取得"
    params do
      requires :invited_id, type: Integer, desc: "招待されたユーザのID"
      requires :code, type: String, desc: "invitationのコード"
    end
    get '/code' do
      invitation = Invitation.where(invited_id: params[:invited_id], code: params[:code])[0]
      theme = Theme.where(id: invitation.theme_id)[0]
      hash = {}
      hash[:result] = true
      hash[:data] = {}
      hash[:data][:invitation] = invitation.attributes
      hash[:data][:invitation][:invited_user] = User.where(id: invitation.invited_id)[0]
      hash[:data][:invitation][:inviter_user] = User.where(id: invitation.inviter_id)[0]
      hash[:data][:invitation][:theme] = theme_response(theme)
      hash
    end


    route_param :invite_id do
      desc "招待されてるテーマを取得"
      params do
        requires :invite_id, type: Integer, desc: "invitationのID"
      end
      get '/' do
        invitation = Invitation.where(id: params[:invite_id])[0]
        theme = Theme.where(id: invitation.theme_id)
        hash = {}
        hash[:result] = true
        hash[:data] = {}
        hash[:data][:invitation] = invitation.attributes
        hash[:data][:invitation][:invited_user] = User.where(id: invitation.invited_id)[0]
        hash[:data][:invitation][:inviter_user] = User.where(id: invitation.inviter_id)[0]
        hash[:data][:invitation][:theme] = theme_response(theme)
        hash
      end

      desc "招待されたテーマに参加"
      params do
        requires :invite_id, type: Integer, desc: "invitationのID"
      end
      post '/' do
        invitation = Invitation.where(id: params[:invite_id])[0]
        invitation.update_attributes(
          joined: true
        )
        joining_user_theme = JoiningUserTheme.new(
          user_id: invitation.invited_id,
          theme_id: invitation.theme_id
        )
        joining_user_theme.save
      end

    end
  end
end