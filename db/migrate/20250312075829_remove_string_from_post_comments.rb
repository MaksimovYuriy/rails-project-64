class RemoveStringFromPostComments < ActiveRecord::Migration[7.2]
  def change
    remove_column :post_comments, :string, :string
  end
end
