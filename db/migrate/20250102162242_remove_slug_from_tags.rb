class RemoveSlugFromTags < ActiveRecord::Migration[7.2]
  def change
    remove_column :tags, :slug, :string
  end
end
