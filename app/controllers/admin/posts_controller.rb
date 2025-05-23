class Admin::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_categories, only: [ :new, :create, :edit, :update, :preview ]
  before_action :set_post, only: [ :edit, :show, :update, :destroy, :preview ]
  def index
    @pagy, @posts = pagy(Post.order(created_at: :desc), limit: 10)
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      redirect_to admin_posts_path, notice: "Post created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @post.assign_attributes(post_params.except(:images))

    if post_params[:images].present?
      @post.images.attach(post_params[:images])
    end

    if params[:remove_images].present?
      params[:remove_images].each do |blob_id|
        attachment = @post.images.attachments.find_by(blob_id: blob_id)
        attachment&.purge
      end
    end

    if @post.save
      redirect_to admin_posts_path, notice: "Post updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @post.destroy
      redirect_to admin_posts_path, alert: "Post deleted."
    else
      redirect_to admin_posts_path, alert: "Unable to delete the post."
    end
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
    params.require(:post).permit(:title, :content, :status, :tag_list, category_ids: [], images: [])
  end

  def set_categories
    @categories = Category.all
  end

  def set_post
    @post = Post.friendly.find(params[:id])
  end
end
