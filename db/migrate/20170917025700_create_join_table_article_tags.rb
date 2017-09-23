class CreateJoinTableArticleTags < ActiveRecord::Migration[5.1]
  def change
    create_join_table :articles, :tags, table_name: :article_tags do |t|
      t.integer :id, :primary_key, first: true
      t.datetime :created_at
      t.index [:article_id, :tag_id]
    end
    add_foreign_key :article_tags, :tags, on_delete: :cascade
    add_foreign_key :article_tags, :articles, on_delete: :cascade
  end
end
