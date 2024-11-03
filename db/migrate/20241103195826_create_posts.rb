class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.string :status, default: 'Draft'
      t.string :slug
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :posts, :title, unique: true
  end
end
