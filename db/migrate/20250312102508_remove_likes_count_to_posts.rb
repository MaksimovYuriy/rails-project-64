class RemoveLikesCountToPosts < ActiveRecord::Migration[7.2]
  def change
    remove_column :posts, :likes_count, :integer
  end
end
