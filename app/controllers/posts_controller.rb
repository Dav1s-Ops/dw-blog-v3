class PostsController < ApplicationController
  def index
    @category = Category.friendly.find(params[:category]) if params[:category]
    scope = if @category
      @category.posts.published.order(created_at: :desc)
    else
      Post.published.order(created_at: :desc)
    end

    @pagy, @posts = pagy(scope, items: 10)
    Rails.logger.info "Number of posts loaded: #{@posts.size}"

    respond_to do |format|
      format.html
      format.json do
        rendered_posts = render_to_string(partial: "posts/post", collection: @posts, formats: [ :html ])
        render json: {
          html: rendered_posts,
          has_more: @pagy.next.present?
        }
      end
    end
  end

  def show
    @post = Post.friendly.find(params[:id])
  end
end
