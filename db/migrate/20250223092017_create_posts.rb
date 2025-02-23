class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    create_table :posts do |t|
      t.references :category, null: false, foreign_key: true
      t.string :title
      t.text :body
      t.references :creator, null: false, foreign_key: true

      t.timestamps
    end
  end
end
