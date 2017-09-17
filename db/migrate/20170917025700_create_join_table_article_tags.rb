class CreateJoinTableArticleTags < ActiveRecord::Migration[5.1]
  def change
    create_join_table :articles, :tags do |t|
      # t.index [:article_id, :tag_id]
      # t.index [:tag_id, :article_id]
      t.datetime :created_at
    end
    add_foreign_key :articles_tags, :tags
    add_foreign_key :articles_tags, :articles
  end
end
