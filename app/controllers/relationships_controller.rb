class RelationshipsController < ApplicationController
  before_action :authenticate_user!


  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end
  # followings, followersは省略
  def followings
     user = User.find(params[:user_id])
     @users = user.followings
  end

  def followers
     user = User.find(params[:user_id])
     @users = user.followers
  end

  def follow
    current_user.follow(params[:id].to_i)
    redirect_to request.referer
  end


  def followed
    user = User.find(params[:user_id])
    @users = user.followers
    # render "relationship/follows"
  end

  def unfollow
    current_user.unfollow(params[:id].to_i)
    redirect_to request.referer
  end




end

