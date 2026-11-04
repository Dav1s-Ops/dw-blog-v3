namespace :export do
  desc "Dump posts, taxonomy and image blobs as JSON for the Astro migration"
  task posts: :environment do
    posts = Post.includes(:categories, :tags, images_attachments: :blob).order(:created_at).map do |post|
      {
        title: post.title,
        slug: post.slug,
        content: post.content,
        status: post.status,
        created_at: post.created_at.utc.iso8601,
        updated_at: post.updated_at.utc.iso8601,
        categories: post.categories.map(&:slug),
        tags: post.tags.map { |t| { id: t.id, name: t.name } },
        images: post.images.map { |i| { filename: i.blob.filename.to_s, key: i.blob.key, content_type: i.blob.content_type } }
      }
    end
    path = Rails.root.join("tmp/export.json")
    File.write(path, JSON.pretty_generate(posts))
    puts "Exported #{posts.size} posts to #{path}"
  end
end
