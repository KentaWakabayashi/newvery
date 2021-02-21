class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).reverse_order
  end

  def edit
    @user = User.find(params[:id])
  end


# おかしい?
  def index
    @users = User.all
    # @user = User.find(current_user.id)
    # @posts = Post.all

  end

  # @usersのイメ-ジ
  @users = [
    {id:1, email: "XXXX", name: "XXXX"},
    {id:2, email: "XXXX", name: "XXXX"},
    {id:3, email: "XXXX", name: "XXXX"},
  ]


  def withdrawal
     @user = current_user
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
