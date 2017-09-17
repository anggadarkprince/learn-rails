class AddDetailsToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :slug, :string, limit: 500, unique: true, null: false, after: :id
    change_table :articles do |t|
      t.index :slug
      t.rename :text, :content
      t.string :featured, limit: 300, after: :content
      t.string :status, limit: 300, default: 'published', after: :content, null: false
      t.integer :views, default: 0, after: :featured
      t.references :category, foreign_key: true, after: :views, on_delete: :cascade
      t.references :user, foreign_key: true, after: :views, on_delete: :cascade
    end

    def up
      change_column :articles, :title, :string, :limit => 200
    end

    def down
      change_column :articles, :title, :string, :limit => 255
    end

    change_column_null :articles, :title, false
    change_column_null :articles, :content, false

    Article.connection.execute("
      ALTER TABLE `articles`
      CHANGE COLUMN `status` `status`
      ENUM('published', 'draft') DEFAULT 'published' ;
    ")

  end
end
