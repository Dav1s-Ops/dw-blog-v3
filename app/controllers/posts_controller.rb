class PostsController < ApplicationController
  def index
    if params[:category_id]
      @category = Category.find(params[:category_id])
      @posts = @category.posts.published
    else
      @posts = Post.published
    end
  end

  def show
    @post = Post.friendly.find(params[:id])
  end
end
