class AddUniqueIndexToPostLike < ActiveRecord::Migration[7.2]
  def change
    add_index :post_likes, [:user_id, :post_id], unique: true, name: 'index_post_likes_on_user_id_and_post_id'
  end
end
