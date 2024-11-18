class Admin::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_categories, only: [ :new, :create, :edit, :update, :preview ]
  before_action :set_post, only: [ :edit, :update, :destroy, :preview ]
  def index
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    # Process tags
    if @post.tag_list.present?
      tag_names = @post.tag_list.split(",").map(&:strip).reject(&:blank?)
      tags = tag_names.map { |name| Tag.find_or_create_by(name: name) }
      @post.tags = tags
    end

    if @post.save
      redirect_to admin_posts_path, notice: "Post created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @post.assign_attributes(post_params)

    # Process tags
    if @post.tag_list.present?
      tag_names = @post.tag_list.split(",").map(&:strip).reject(&:blank?)
      tags = tag_names.map { |name| Tag.find_or_create_by(name: name) }
      @post.tags = tags
    end

    if @post.save
      redirect_to admin_posts_path, notice: "Post updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
  end

  def preview
    if params[:id]
      @post.assign_attributes(post_params)
    else
      @post = Post.new(post_params)
      @post.user = current_user
    end

    flash.now[:preview] = true
    render params[:id] ? :edit : :new
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :status, :tag_list, category_ids: [])
  end

  def set_categories
    @categories = Category.all
  end

  def set_post
    @post = Post.friendly.find(params[:id])
  end
end
