class PostsController < ApplicationController
  def index
    if params[:category]
      @category = Category.friendly.find(params[:category])
      @posts = @category.posts.published
    else
      @posts = Post.published
    end
  end

  def show
    @post = Post.friendly.find(params[:id])
  end
end
