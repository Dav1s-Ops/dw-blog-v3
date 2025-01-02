class TagsController < ApplicationController
  def show
    @tag = Tag.find_by!(name: params[:id])
    @pagy, @posts = pagy(@tag.posts.published.order(created_at: :desc), items: 10)
    @random_tags = Tag.joins(:posts)
      .where.not(id: @tag.id)
      .distinct
      .sample(3)
  end
end
