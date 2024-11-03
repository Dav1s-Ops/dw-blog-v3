class ChangeStatusToIntegerInPosts < ActiveRecord::Migration[7.2]
  def change
    remove_column :posts, :status, :string

    add_column :posts, :status, :integer, default: 0
  end
end
