class UsersController < ApplicationController
  def show
    @user = User.find(current_user.id)
  end

  def withdrawal
     @user = current_user
  end
end
