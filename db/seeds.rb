puts "—————— Clearing existing data..."

Post.destroy_all
User.destroy_all
Category.destroy_all
Tag.destroy_all

puts "—————— Data cleared."
puts "Creating user..."

admin = User.create!(
  email: 'admin@example.com',
  password: 'password',
  password_confirmation: 'password'
)

puts "—————— User created: #{admin.email}"
puts "Creating categories..."

categories = [ 'Frontend', 'Backend', 'Fullstack', 'DevOps', 'News', 'Personal' ].map do |category_name|
  Category.create!(name: category_name)
end

puts "—————— Categories created: #{categories.map(&:name).join(', ')}"
puts "Creating tags..."

tags = [ 'JavaScript', 'Python', 'Ruby', 'Java', 'C++', 'C#', 'HTML', 'CSS', 'SQL', 'React', 'Angular', 'Vue', 'Node.js', 'Django', 'Flask', 'Rails', 'Spring Boot', 'Git', 'Docker', 'Kubernetes', 'AWS', 'Azure', 'GCP', 'REST', 'GraphQL', 'TypeScript', 'Swift', 'Objective-C', 'Kotlin', 'Go', 'Rust', 'PHP', 'Bash', 'Perl', 'Linux', 'Windows', 'macOS', 'Agile', 'Scrum', 'TDD', 'DevOps', 'Machine Learning', 'AI', 'Data Science', 'Cybersecurity', 'Blockchain', 'Web Development', 'Mobile Development', 'Frontend', 'Backend', 'Fullstack' ].map do |tag_name|
  Tag.create!(name: tag_name)
end

puts "—————— Tags created: #{tags.map(&:name).join(', ')}"
puts "Creating posts..."

file_path_1 = Rails.root.join('db/sample_posts/sample_post_md.md')
file_path_2 = Rails.root.join('db/sample_posts/sample_post_ruby.md')
file_path_3 = Rails.root.join('db/sample_posts/sample_post_js.md')

50.times do |i|
  post = Post.create!(
    title: "Sample Post #{i + 1}",
    content: File.read([ file_path_1, file_path_2, file_path_3 ].sample),
    status: Post.statuses.keys.sample,
    user: admin,
    categories: categories.sample(rand(3..(categories.length - 1))),
    tags: tags.sample(rand(10..(tags.length - 1)))
  )

  # Associate random categories and tags
  # post.categories << categories.sample(rand(0..4))
  # post.tags << tags.sample(rand(0..5))

  # Generate slug using FriendlyId
  post.save!

  puts "Created post: #{post.title}"
end

puts "Data added, happy blogging!"
