class SearchController < ApplicationController


def search
    @model = params[:model]
    search = params[:search]
    @keyword = params[:keyword]
    @user = current_user
  if @model == "1"
      @users = User.search(search,@keyword)
  else
      @posts = Post.search(search,@keyword).page(params[:page])
  end

end


end