class AddColumnSlugToTag < ActiveRecord::Migration[5.1]
  def change
    add_column :tags, :slug, :string, after: :id, null: false
    add_index :tags, :slug
  end
end
