
include Response
include Helpers


class Users::Blocks < Grape::API
  resource :users do
    params do
      requires :user_id, type: Integer, desc: 'user_id'
    end

    get '/blocks', jbuilder: 'users' do
      @users = User.find(params[:user_id]).block_users
    end

    params do
      requires :user_id, type: Integer, desc: 'user_id'
      requires :block_user_id, type: Integer, desc: 'user_id'
    end

    post '/blocks', jbuilder: 'users' do
      user = User.find(params[:user_id])
      block_user = User.find(params[:block_user_id])
      if block_user.id == user.id
        raise ArgumentError.new "user_id must be not current"
      end
      Block.create!(
        block_user_id: block_user.id,
        blocked_by_user_id: user.id
      )

      @users = user.block_users
    end

    params do
      requires :user_id, type: Integer, desc: 'user_id'
      requires :block_user_id, type: Integer, desc: 'user_id'
    end

    delete '/blocks', jbuilder: 'users' do
      user = User.find(params[:user_id])
      block_user = User.find(params[:block_user_id])

      Block.find_by!(
        block_user_id: block_user.id,
        blocked_by_user_id: user.id
      ).destroy!

      @users = current_user.block_users
    end
  end
end
