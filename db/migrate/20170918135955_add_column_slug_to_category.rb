class AddColumnSlugToCategory < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :slug, :string, after: :id, null: false
    add_index :categories, :slug
  end
end
