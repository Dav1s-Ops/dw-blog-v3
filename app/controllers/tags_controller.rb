class TagsController < ApplicationController
  def show
    @tag = Tag.find_by!(name: params[:id])
    @posts = @tag.posts.published.order(created_at: :desc)
    @random_tags = Tag.joins(:posts)
      .where.not(id: @tag.id)
      .distinct
      .sample(3)
  end
end
