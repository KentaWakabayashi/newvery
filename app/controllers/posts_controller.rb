class PostsController < ApplicationController

  def new
    @post = Post.new
    @post.post_images.build
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
    redirect_to posts_path
    else
      render :new
    end
  end

  def index
    @posts = Post.all
    @posts = Post.page(params[:page]).reverse_order
  end

  def show

    @post = Post.find(params[:id])
    @post_comment = PostComment.new

  end

  def destroy

    @post = Post.find(params[:id])
    @post.destroy



    redirect_to posts_path
  end

  def edit
    @post = Post.find(params[:id])
  end


  def update
    post = Post.find(params[:id])
    post.update(post_params)
    redirect_to  edit_post_path(post)
  end


  private

  def post_params
    params.require(:post).permit(:address, :text, post_images_images: [])
  end
end
