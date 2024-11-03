class PostsController < ApplicationController
  def index
    @posts = Post.where(status: :published)
  end

  def show
    @post = Post.friendly.find(params[:id])
  end
end
