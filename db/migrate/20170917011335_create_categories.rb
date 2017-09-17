class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :category, null: false, limit: 50
      t.string :description, null: false, limit: 500
      t.string :featured, limit: 300
      t.references :category, foreign_key: true, optional: true
      t.timestamps
    end
  end
end
